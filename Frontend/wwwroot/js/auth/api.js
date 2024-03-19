function getAccessToken() {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-at=")) {
            return cookie.substring(7);
        }
    }
    var rt = getRefreshToken();
    if (rt != null && rt != undefined) {
        fetch("http://localhost:5020/api/refresh_token", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
            body: JSON.stringify({
                userId: parseInt(getUserId()),
                refreshToken: rt,
            })
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.accessToken != null && data.accessToken != undefined) {
                    document.cookie = `web-at=${data.accessToken}; path=/`;
                    document.cookie = `web-rt=${data.refreshtoken}; path=/`;
                    document.cookie = `user-id=${data.userid}; path=/`;
                    getAccessToken()
                } else {
                    window.location.href = "/";
                }
            }).catch(e => {
                window.location.href = "/";
            });
    } else {
        window.location.href = "/";
    }
    return null;
}` `

function getRefreshToken() {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-rt=")) {
            return cookie.substring(7);
        }
    }
    return null;
}

function getUserId() {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("user-id=")) {
            return cookie.substring(8);
        }
    }
    return null;
}

function setCookie(name, value, days) {
    const expires = new Date();
    expires.setTime(expires.getTime() + days * 24 * 60 * 60 * 1000);
    document.cookie = `${name}=${value};expires=${expires.toUTCString()};path=/`;
}

async function callAPI(endpoint, method, data) {
    let accessToken = getAccessToken();
    const refreshToken = getRefreshToken();

    if (!accessToken) {
        if (!refreshToken) {
            window.location.href = '/login'; // Navigate to login screen if both access token and refresh token are not found
            return;
        }

        try {
            const response = await fetch('/refresh-token-endpoint', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ refresh_token: refreshToken })
            });

            if (response.ok) {
                const responseData = await response.json();
                accessToken = responseData.access_token;
                setCookie('web-at', accessToken, 7);
            } else {
                throw new Error('Failed to refresh access token');
            }
        } catch (error) {
            console.error('Error refreshing access token:', error);
            window.location.href = '/login'; 
            return;
        }
    }

    const requestOptions = {
        method: method,
        headers: {
            'Authorization': `Bearer ${accessToken}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    };

    try {
        const response = await fetch(endpoint, requestOptions);
        const responseData = await response.json();
        return responseData;
    } catch (error) {
        console.error('Error:', error);
        throw error; // Handle error appropriately in your application
    }
}

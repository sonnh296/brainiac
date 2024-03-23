function getAccessToken() {

    if (getUserId() == null || getUserId() == undefined) {
        document.cookie = `web-at=;max-age=0; path=/`;
        document.cookie = `web-rt=; max-age=0;path=/`;
        document.cookie = `user-id=; max-age=0;path=/`;
        //window.location.href = "/";
    }
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
                    document.cookie = `web-at=${data.accessToken};max-age=900; path=/`;
                    document.cookie = `web-rt=${data.refreshtoken}; max-age=864000;path=/`;
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
}

function getRefreshToken() {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-rt=")) {
            if (cookie.substring(7) == undefined)
                return null;
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

function checkCUrrentRole(roleCheck) {
    var AC_exist = false;
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-at=")) {
            AC_exist = true;
            var tk = cookie.substring(7);
            fetch("http://localhost:5020/api/User/CurrentUser", {
                headers: { Authorization: `Bearer ${tk}` },
            })
                .then((response) => response.json())
                .then((data) => {
                    role = data.role;
                    if (role != null && role != undefined) {
                        return roleCheck == role
                    }
                });
        }
    }
    if (!AC_exist) {
        getAccessToken();
    }
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-at=")) {
            AC_exist = true;
            var tk = cookie.substring(7);
            fetch("http://localhost:5020/api/User/CurrentUser", {
                headers: { Authorization: `Bearer ${tk}` },
            })
                .then((response) => response.json())
                .then((data) => {
                    role = data.role;
                    if (role != null && role != undefined) {
                        return roleCheck == role
                    }
                });
        }
    }
    return false;
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

function checkIsLoginFilter() {
    var AC_exist = false;
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-at=")) {
            AC_exist = true;
            var tk = cookie.substring(7);
            fetch("http://localhost:5020/api/User/CurrentUser", {
                headers: { Authorization: `Bearer ${tk}` },
            })
                .then((response) => response.json())
                .then((data) => {
                    role = data.role;
                    if (role != null && role != undefined) {
                        if (role == "Student") {
                            window.location.href = "/homepage";
                        }
                        if (role == "Admin") {
                            window.location.href = "/admin/manageaccount";
                        }
                        if (role == "Teacher") {
                            window.location.href = "/teacher/dashboard";
                        }
                    }
                });
        }
    }
    if (!AC_exist) {
        getAccessToken();
    }
}

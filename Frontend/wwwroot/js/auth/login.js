export const login = (email, password) => {
    fetch(endpoint, {
        method: "POST",
        credentials: "include",
        headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
        },
        body: JSON.stringify({
            email: email,
            password: password,
        })
    }).then(data => {
        if (data.error === "") {
            document.cookie = `web-at=${data.token}; path=/`;

            if (!data.role) {
                window.location.href = '/';
            }
            if (data.role == "student") {
                window.location.href = "/";
            }
            window.location.href = "/" + data.role + '/dashboard';
        }
    }).catch(e => console.log("error::", e));
};

export const logOut = (userId) => {
    return new Promise((resolve, reject) => {
        let endpoint = `http://api.your-domain-here.ngrok.io/api/core/v1/sessions/${userId}`;
        fetch(endpoint, {
            method: "DELETE",
            credentials: "include",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
        })
            .then(e => {
                if (e.ok) {
                    resolve(e);
                } else {
                    reject(e);
                }
            })
            .catch(e => console.log("error::", e));
    });
};
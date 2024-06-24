console.log("Reply module.......");

let replyService = (function() {
    async function add(reply, callback, error) {
        console.log("add reply.......");

        try {
            let url = "/replies/new";

            const res = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=utf-8"
                },
                body: JSON.stringify(reply)
            });

            if(res.ok) {
                let result = await res.text();
                callback(result);
            } else {
                error("status code not ok");
            }
        } catch(err) {
            console.log(err);

            return err;
        }
    }

    async function getList(param, callback, error) {
        let bno = param.bno;
        let page = param.page || 1;
        let url = "/replies/pages/" + bno + "/" + page + ".json";

        const res = await fetch(url);

        if(res.ok) {
            let result = await res.json();
            console.log("json ", result);
            callback(result.replyCnt, result.list);
        } else {
            error("status code not ok");
        }
    }

    async function remove(rno, callback, error) {
        let url = "/replies/" + rno;

        let res = await fetch(url, {
            method: "delete"
        });

        if(res.ok) {
            let result = await res.text();
            console.log("text ", result)
            callback(result);
        } else {
            error("status code not ok");
        }
    }

    async function update(reply, callback, error) {
        console.log("RNO: " + reply.rno);

        let url = "/replies/" + reply.rno;
        let res = await fetch(url, {
            method: "put",
            headers: {
                "Content-Type": "application/json; charset=UTF-8"
            },
            body: JSON.stringify(reply)
        });

        if(res.ok) {
            let result = await res.text();
            console.log("text", result);
            callback(result);
        } else {
            error("status code not ok");
        }
    }

    async function get(rno, callback, error) {
        let url = "/replies/" + rno + ".json";
        let res = await fetch(url);

        if(res.ok) {
            let result = await res.json();
            callback(result);
        } else {
            error("status code not ok");
        }
    }

    function displayTime(timeValue) {
        let today = new Date();
        let gap = today.getTime() - timeValue;
        let dateObj = new Date(timeValue);
        let str = "";

        if(gap < (1000 * 60 * 60 * 24)) {
            let hh = dateObj.getHours();
            let mi = dateObj.getMinutes();
            let ss = dateObj.getSeconds();

            return [(hh > 9 ? "" : "0") + hh, ":", (mi > 9 ? "" : "0") + mi, ":", (ss > 9 ? "" : "0") + ss].join("");
        } else {
            let yy = dateObj.getFullYear();
            let mm = dateObj.getMonth() + 1;
            let dd = dateObj.getDate();

            return [yy, "/", (mm > 9 ? "" : "0") + mm, "/", (dd > 9 ? "" : "0") + dd].join("");
        }
    }

    return {
        add: add,
        get: get,
        getList: getList,
        remove: remove,
        update: update,
        displayTime: displayTime
    };
})();
const BulletinContainers = {};
const audio = document.createElement("audio");
let MaxQueue = 5
let styled = false;


class NotificationContainer {
    constructor(position) {
        this.container = document.getElementById("bulletin_container");
        this.el = document.createElement("div");
        this.el.classList.add("notification-notification-container");
        this.el.classList.add(`notification-container-${position}`);
        this.notifications = [];
        this.offset = 0;
        this.spacing = () => { return document.documentElement.clientHeight * 0.01 }; // 1vh
        this.queue = 0;
        this.maxQueue = MaxQueue;
        this.canAdd = true;
        this.processQueue(true);

    }

    processQueue(loop) {
        let handled = false
        for (var i = this.notifications.length - 1; i >= 0; i--) {
            let n = this.notifications[i]
            if (n.inQueue === true) {
                if (handled === false || n.pinned) {
                    n.show()
                }
                if (!n.pinned) {
                    handled = true
                }
            }
        }
        if (loop === true) {
            setTimeout(() => {
                this.processQueue(true);
            }, 250);
        }
    }

    addNotification(notification) {

        if (!notification.pinned) {
            this.queue++;
        }

        this.el.appendChild(notification.el);

        if (this.queue >= this.maxQueue) {
            this.canAdd = false;
        }
    }

    removeNotification(notification) {

        const index = this.notifications.indexOf(notification);

        if (index > -1) {

            clearTimeout(notification.timeout);

            PostData("removed", {
                id: notification.id
            });

            this.notifications.splice(index, 1);

            this.el.removeChild(notification.el);

            this.queue--;

            if (this.queue < this.maxQueue) {
                this.canAdd = true;
            }
        }
    }

    add() {
        if (!this.container.contains(this.el)) {
            this.container.appendChild(this.el);
        }
    }

    remove() {
        this.container.removeChild(this.el);
    }

    empty() {
        return this.el.children.length < 1;
    }

    rearrange() {
        let posY = 0;

        this.notifications.sort((a, b) => {
            if (a.pinned !== b.pinned) {
                return Number(a.pinned) - Number(b.pinned)
            }
            if (a.pinned === true && b.pinned === true) {
                return a.id - b.id;
            }
            return b.id - a.id;
        })
        for (const n of this.notifications) {
            if (n.inQueue === false || n.pinned) {
                const rn = n.el.getBoundingClientRect();

                let current = parseInt(n.el.style.bottom)
                let desired = posY
                if (n.bottom) {
                    n.el.style.transition = `transform 250ms ease 0ms`;
                    n.el.style.transform = `translate3d(0px, ${current - desired}px, 0px)`;
                } else {
                    n.el.style.transition = `transform 250ms ease 0ms`;
                    n.el.style.transform = `translate3d(0px, ${current + desired}px, 0px)`;
                }

                n.offset = posY

                posY += rn.height + this.spacing();
            }
        }
    }

    getHeight() {
        let h = 0
        for (const n of this.notifications) {
            if (n.inQueue === false || n.pinned) {
                const rn = n.el.getBoundingClientRect();
                if (rn.height > 0) {
                    h += rn.height + this.spacing();
                }
            }
        }
        return h
    }
}

class Notification {
    constructor(cfg, id, message, interval, position, progress = false, theme = "default", exitAnim = "fadeOut", flash = false, pinned = false, group, hideStack, title, subject, icon) {
        this.cfg = cfg
        this.id = id;
        this.message = message;
        this.interval = interval;
        this.position = position;
        this.title = title;
        this.rawTitle = title;
        this.subject = subject;
        this.rawSubject = subject;
        this.message = message;
        this.rawMessage = message;
        this.icon = icon;
        this.progress = progress;
        this.offset = 0;
        this.theme = theme;
        this.exitAnim = exitAnim;
        this.flash = flash;
        this.group = group;
        this.hideStack = hideStack;
        this.count = 1;
        this.pinned = pinned;
        this.inQueue = true;

        this.el = document.createElement("div");
        this.el.classList.add("notification-notification");
        this.contentEl = document.createElement("div");
        this.contentEl.classList.add("notification-notification-content");
        this.el.appendChild(this.contentEl);
        this.el.classList.toggle("flash", this.flash);
        this.el.classList.toggle("pinned", this.pinned === true);
        this.el.classList.add(this.theme);

        this.bottom = this.position.toLowerCase().includes("bottom")

        if (this.position in BulletinContainers) {
            this.container = BulletinContainers[this.position];
        } else {
            this.container = new NotificationContainer(this.position);
            BulletinContainers[this.position] = this.container;
        }
        this.container.notifications.unshift(this);

        this.init();
        if (this.container.canAdd || this.pinned) {
            this.container.processQueue();
        }
    }

    addProgress() {
        this.el.classList.add("with-progress");
        this.progressEl = document.createElement("div");
        this.progressEl.classList.add("notification-progress");

        this.barEl = document.createElement("div");
        this.barEl.classList.add("notification-bar");

        this.progressEl.appendChild(this.barEl);

        this.el.appendChild(this.progressEl);
    }

    removeProgress() {
        if (this.progressEl !== undefined) {
            this.el.removeChild(this.progressEl);
        }
        this.progressEl = undefined;
        this.barEl = undefined;
        this.el.classList.remove("with-progress");
    }

    show() {

        if (this.container.canAdd || this.pinned) {

            this.inQueue = false;

            if (this.cfg.SoundFile && audio.paused) {
                audio.setAttribute("src", `audio/${this.cfg.SoundFile}`);
                audio.volume = this.cfg.SoundVolume;
                audio.currentTime = 0;
                audio.play();
            }

            if (this.bottom) {
                if (this.pinned) {
                    this.el.style.bottom = `${this.container.getHeight()}px`;
                } else {
                    this.el.style.bottom = `${this.container.offset}px`;
                }
            } else {
                if (this.pinned) {
                    this.el.style.top = `${this.container.getHeight()}px`;
                } else {
                    this.el.style.top = `${this.container.offset}px`;
                }
            }

            this.container.add();

            this.container.addNotification(this);

            this.el.classList.add("active");

            if (this.progress) {
                this.el.classList.add("progress");
                this.barEl.style.animationDuration = `${this.interval}ms`;
                this.progressEl.addEventListener('animationend', () => {
                    this.removeProgress()
                });
            }

            this.container.rearrange()

            if (!this.pinned) {
                this.hide();
            }
        }
    }

    remove() {

        this.el.classList.remove("active");
        this.el.classList.add("hiding");
        this.hiding = true;

        PostData("hiding", {
            id: this.id
        });

        if (this.exitAnim) {
            this.el.style.animationName = this.exitAnim;
        }

        setTimeout(() => {
            this.container.removeNotification(this);
            this.container.rearrange()
        }, this.cfg.AnimationTime);
    }

    hide() {

        this.timeout = setTimeout(() => {
            this.remove()
        }, this.interval);
    }

    stack(options) {

        if (options.hasOwnProperty('hideStack')) {
            this.hideStack = options.hideStack
        }

        if (this.cfg.ShowStackedCount && !this.hideStack) {
            this.count += 1;
        } else {
            this.count = 1
        }

        this.update(options, true);
    }

    update(options, refresh) {

        if (options.hasOwnProperty('pinned')) {
            this.pinned = options.pinned
            this.el.classList.toggle("pinned", this.pinned === true);
        }

        if (refresh) {

            if (options.hasOwnProperty('interval')) {
                this.interval = options.interval
            }

            if (options.hasOwnProperty('progress')) {
                this.progress = options.progress
            }

            clearTimeout(this.timeout);

            this.removeProgress()
            this.el.classList.remove("progress");
            void this.el.offsetWidth;

            if (this.progress) {
                this.addProgress()
                this.el.classList.add("progress");
                this.barEl.style.animationDuration = `${this.interval}ms`;
                this.progressEl.addEventListener('animationend', () => {
                    this.removeProgress()
                });
            }

            if (options.hasOwnProperty('hideStack')) {
                this.hideStack = options.hideStack
            }

            this.el.classList.remove("stacked");
            if (this.cfg.ShowStackedCount && !this.hideStack && this.count > 1) {
                this.el.classList.add("stacked");
                this.el.dataset.count = this.count;
            }

            if (!this.pinned && this.inQueue === false) {
                this.hide();
            }
        }

        if (this.type == 'advanced') {
            if (options.hasOwnProperty('title')) {
                this.title = this.parseMessage(options.title);
            }

            if (options.hasOwnProperty('subject')) {
                this.subject = this.parseMessage(options.subject);
            }

            if (options.hasOwnProperty('message')) {
                this.message = this.parseMessage(options.message);
            }

            if (options.hasOwnProperty('icon')) {
                this.iconEl.innerHTML = `<img src="${options.icon}" />`;
            }

            this.titleEl.innerHTML = this.title;
            this.subjectEl.innerHTML = this.subject;
            this.messageEl.innerHTML = this.message;
        } else if (this.type == 'standard') {
            if (options.hasOwnProperty('message')) {
                this.message = this.parseMessage(options.message);
            }

            this.messageEl.innerHTML = this.message;
        }

        if (options.hasOwnProperty('theme')) {
            this.el.classList.remove(this.theme);

            this.theme = options.theme;
            this.el.classList.add(this.theme);
        }

        if (options.hasOwnProperty('flash') && options.flash == true) {
            this.el.classList.remove("flash");

            setTimeout(() => {
                this.el.classList.add("flash");
            }, 1);
        }

        if (this.pinned && this.inQueue === true) {
            this.show()
        }

        this.container.rearrange();
    }

    parseMessage(message) {
        const regexColor = /~([^h])~([^~]+)/g;
        const regexBold = /~([h])~([^~]+)/g;
        const regexStop = /~s~/g;
        const regexLine = /\n/g;

        message = message.replace(regexColor, "<span class='$1'>$2</span>").replace(regexBold, "<span class='$1'>$2</span>").replace(regexStop, "").replace(regexLine, "<br />");

        return message;
    }
}

class StandardNotification extends Notification {
    constructor(cfg, id, message, interval, position, progress = false, theme = "default", exitAnim = "fadeOut", flash = false, pinned = false, group, hideStack) {
        super(cfg, id, message, interval, position, progress, theme, exitAnim, flash, pinned, group, hideStack);
    }

    init() {
        this.type = 'standard';
        this.message = this.parseMessage(this.message);

        this.messageEl = document.createElement("div");
        this.messageEl.classList.add("notification-text");

        this.messageEl.innerHTML = this.message;
        this.contentEl.appendChild(this.messageEl);


        if (this.progress) {
            this.addProgress()
        }
    }
}

class AdvancedNotification extends Notification {
    constructor(cfg, id, message, title, subject, icon, interval, position, progress = false, theme = "default", exitAnim = "fadeOut", flash = false, pinned = false, group, hideStack) {
        super(cfg, id, message, interval, position, progress, theme, exitAnim, flash, pinned, group, hideStack, title, subject, icon);
    }

    init() {

        this.type = 'advanced';
        this.title = this.parseMessage(this.title);
        this.subject = this.parseMessage(this.subject);
        this.message = this.parseMessage(this.message);

        this.headerEl = document.createElement("div");
        this.headerEl.classList.add("notification-header");

        this.iconEl = document.createElement("div");
        this.iconEl.classList.add("notification-icon");

        this.titleEl = document.createElement("div");
        this.titleEl.classList.add("notification-title");

        this.subjectEl = document.createElement("div");
        this.subjectEl.classList.add("notification-subject");

        this.messageEl = document.createElement("div");
        this.messageEl.classList.add("notification-message");

        this.iconEl.innerHTML = `<img src="${this.icon}" />`;
        this.titleEl.innerHTML = this.title;
        this.subjectEl.innerHTML = this.subject;
        this.messageEl.innerHTML = this.message;

        this.headerEl.appendChild(this.iconEl);
        this.headerEl.appendChild(this.titleEl);
        this.headerEl.appendChild(this.subjectEl);
        this.contentEl.appendChild(this.headerEl);
        this.contentEl.appendChild(this.messageEl);

        if (this.progress) {
            this.addProgress()
        }
    }
}

const onData = function (e) {
    const data = e.data;
    if (data.type) {

        if (!styled && data.config) {
            let css = `
            .animate__animated {
                -webkit-animation-duration: ${data.config.AnimationTime};
                animation-duration: ${data.config.AnimationTime};
            }

            .notification-notification.active {
                opacity: 0;
                animation: fadeIn ${data.config.AnimationTime}ms ease 0ms forwards;
            }

            .notification-notification.active.flash {
                opacity: 1;
                animation-name: ${data.config.FlashType};
            }

            .notification-notification.hiding {
                opacity: 1;
                animation: ${data.config.AnimationOut} ${data.config.AnimationTime}ms ease 0ms forwards;
            }`;

            if (data.config.FlashType == "flash") {
                css += `
                    .notification-notification.active.flash {
                        animation-iteration-count: ${data.config.FlashCount};
                    }
                `;
            }

            document.head.insertAdjacentHTML("beforeend", `<style>${css}</style>`);

            styled = true
        }

        if (data.type == "standard" || data.type == "advanced") {
            MaxQueue = data.config.Queue;

            let handled = false
            if (data.updateGroup) {
                let n = getNotificationByID(data.id)
                if (n !== undefined) {
                    n.update(data, true);
                    handled = true
                }
            } else if (data.stack) {
                let n = getNotificationByID(data.id)
                if (n !== undefined) {
                    n.stack(data)
                    handled = true
                }
            }
            if (handled === false) {
                if (data.type == "standard") {
                    new StandardNotification(data.config, data.id, data.message, data.timeout, data.position, data.progress, data.theme, data.exitAnim, data.flash, data.pinned, data.group, data.hideStack);
                } else {
                    new AdvancedNotification(data.config, data.id, data.message, data.title, data.subject, data.icon, data.timeout, data.position, data.progress, data.theme, data.exitAnim, data.flash, data.pinned, data.group, data.hideStack);
                }
            }
        } else if (data.type == "remove") {
            let n = getNotificationByID(data.id)
            if (n !== undefined) {
                n.remove()
            }
        } else if (data.type == "update") {
            let n = getNotificationByID(data.id)
            if (n !== undefined) {
                n.update(data.options, data.refresh || data.options.refresh)
            }
        } else if (data.type == "hud_visible") {
            if (data.visible) {
                document.getElementById('bulletin_container').style.opacity = '1'
            } else {
                document.getElementById('bulletin_container').style.opacity = '0'
            }
        }
    }
};

function getNotificationByID(id) {
    for (const position in BulletinContainers) {
        for (const notification of BulletinContainers[position].notifications) {
            if (notification.id === id) {
                return notification
            }
        }
    }
}

function PostData(type = "", data = {}) {
    fetch(`https://${GetParentResourceName()}/nui_${type}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    }).then(resp => resp.json()).then(resp => resp).catch(error => console.log('BULLETIN FETCH ERROR!', type, error.message));
}

window.onload = function (e) {
    window.addEventListener('message', onData);
};

document.addEventListener("DOMContentLoaded", function () {
    fetch(`https://${GetParentResourceName()}/nui_ready`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => resp).catch(error => console.log('BULLETIN FETCH ERROR!', error.message));
});

addEventListener('resize', (event) => {
    for (const position in BulletinContainers) {
        BulletinContainers[position].rearrange();
    }
})

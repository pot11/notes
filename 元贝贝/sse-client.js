// sse-client.js
class SSEClient {
    constructor() {
        this.eventSource = null;
        this.isConnected = false;
        this.connectButton = document.getElementById('connectBtn');
        this.disconnectButton = document.getElementById('disconnectBtn');
        this.statusDiv = document.getElementById('connectionStatus');
        this.messagesDiv = document.getElementById('messages');

        this.initEventListeners();
    }

    initEventListeners() {
        this.connectButton.addEventListener('click', () => this.connect());
        this.disconnectButton.addEventListener('click', () => this.disconnect());
    }

    connect() {
        // 检查是否已经连接
        if (this.eventSource) {
            this.disconnect();
        }

        // 创建 SSE 连接
        this.eventSource = new EventSource('http://192.168.0.161:9113/admin/sse/info');

        // 连接打开事件
        this.eventSource.onopen = (event) => {
            console.log('SSE 连接已建立:', event);
            this.isConnected = true;
            this.updateConnectionStatus('已连接', 'connected');
            this.appendMessage('连接已建立', 'info');
        };

        // 接收消息事件
        this.eventSource.onmessage = (event) => {
            const data = event.data;
            console.log('收到消息:', data);

            // 如果是 "pong" 消息，表示连接建立确认
            if (data === 'pong') {
                this.appendMessage(`心跳确认: ${data}`, 'pong');
            } else {
                // 处理其他类型的消息
                this.appendMessage(`消息: ${data}`, 'normal');
            }
        };

        // 错误处理
        this.eventSource.onerror = (event) => {
            console.error('SSE 连接出错:', event);
            this.isConnected = false;
            this.updateConnectionStatus('连接出错', 'disconnected');
            this.appendMessage('连接出错，请检查网络或重新连接', 'error');

            // 自动重连机制
            setTimeout(() => {
                if (!this.isConnected) {
                    this.connect();
                }
            }, 5000);
        };

        // 监听自定义事件（如果后端发送了命名事件）
        this.eventSource.addEventListener('custom-event', (event) => {
            const customData = JSON.parse(event.data);
            this.appendMessage(`自定义事件: ${JSON.stringify(customData)}`, 'custom');
        });
    }

    disconnect() {
        if (this.eventSource) {
            this.eventSource.close();
            this.eventSource = null;
            this.isConnected = false;
            this.updateConnectionStatus('已断开', 'disconnected');
            this.appendMessage('连接已断开', 'info');
        }
    }

    updateConnectionStatus(status, className) {
        this.statusDiv.textContent = status;
        this.statusDiv.className = `status ${className}`;
    }

    appendMessage(message, type) {
        const messageElement = document.createElement('div');
        messageElement.className = `message message-${type}`;

        const timestamp = new Date().toLocaleString();
        messageElement.innerHTML = `
            <small>[${timestamp}]</small><br>
            <span>${message}</span>
        `;

        this.messagesDiv.appendChild(messageElement);
        this.messagesDiv.scrollTop = this.messagesDiv.scrollHeight;
    }
}

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', () => {
    window.sseClient = new SSEClient();
});

// 页面关闭前断开连接
window.addEventListener('beforeunload', () => {
    if (window.sseClient && window.sseClient.eventSource) {
        window.sseClient.disconnect();
    }
});

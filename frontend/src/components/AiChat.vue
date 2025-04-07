<template>
  <div class="ai-chat-container">
    <div class="chat-history" ref="chatHistory">
      <div v-for="(message, index) in chatHistory" :key="index" :class="['message', message.type]">
        <div class="message-content">{{ message.content }}</div>
      </div>
    </div>
    <div class="input-area">
      <el-input
        v-model="userInput"
        type="textarea"
        :rows="3"
        placeholder="请输入您的问题..."
        @keyup.enter.ctrl="sendMessage"
      />
      <el-button type="primary" @click="sendMessage" :loading="loading">
        发送
      </el-button>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'AiChat',
  data() {
    return {
      userInput: '',
      chatHistory: [],
      loading: false
    };
  },
  methods: {
    async sendMessage() {
      if (!this.userInput.trim()) return;

      const userMessage = this.userInput.trim();
      this.chatHistory.push({
        type: 'user',
        content: userMessage
      });

      this.loading = true;
      this.userInput = '';

      try {
        const response = await axios.post('/api/chat', {
          prompt: userMessage
        });

        this.chatHistory.push({
          type: 'ai',
          content: response.data.response
        });
      } catch (error) {
        this.chatHistory.push({
          type: 'error',
          content: '抱歉，发生了一些错误，请稍后重试。'
        });
        console.error('Error:', error);
      } finally {
        this.loading = false;
        this.$nextTick(() => {
          this.scrollToBottom();
        });
      }
    },
    scrollToBottom() {
      const chatHistory = this.$refs.chatHistory;
      chatHistory.scrollTop = chatHistory.scrollHeight;
    }
  }
};
</script>

<style scoped>
.ai-chat-container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  padding: 20px;
  box-sizing: border-box;
  width: 80%; /* 可以根据你的喜好调整这个百分比 */
  margin: 0 auto; /* 让容器在页面中居中显示 */
}

/* 其余样式保持不变 */
.chat-history {
  flex: 1;
  overflow-y: auto;
  margin-bottom: 20px;
  padding: 10px;
  background: #f5f7fa;
  border-radius: 8px;
}

.message {
  margin-bottom: 15px;
  max-width: 80%;
}

.message.user {
  margin-left: auto;
}

.message.ai {
  margin-right: auto;
}

.message-content {
  padding: 12px 16px;
  border-radius: 8px;
  line-height: 1.5;
}

.user .message-content {
  background: #409EFF;
  color: white;
}

.ai .message-content {
  background: white;
  color: #333;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}

.error .message-content {
  background: #F56C6C;
  color: white;
}

.input-area {
  display: flex;
  gap: 10px;
}

.input-area .el-button {
  align-self: flex-end;
}
</style>
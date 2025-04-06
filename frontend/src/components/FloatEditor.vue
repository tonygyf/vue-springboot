<template>
  <div class="float-editor" v-if="visible">
    <div class="editor-backdrop" @click="close"></div>
    <div class="editor-card">
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: 'FloatEditor',
  props: {
    visible: Boolean
  },
  emits: ['close'],
  methods: {
    close() {
      this.$emit('close');
    }
  }
};
</script>

<style scoped>
.float-editor {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 2000;
}

.editor-backdrop {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.3);
}

.editor-card {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
  padding: 30px;
  min-width: 300px;
}
</style>

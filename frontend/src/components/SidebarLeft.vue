<template>
  <div class="sidebar-left">
    <button class="action-btn" @click="$emit('create-new')">
      <i class="fas fa-plus"></i> 写博客
    </button>
    <button class="action-btn" @click="$emit('view-my-blogs')">
      <i class="fas fa-book"></i> 我的博客
    </button>
    <button class="action-btn" @click="$emit('view-blog-list')">
      <i class="fas fa-list"></i> 博客列表
    </button>
  </div>
</template>

<style scoped>
.sidebar-left {
  position: fixed;
  left: calc((100% - 1440px) / 2 - 100px);
  top: 20px;
  width: 180px;
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
  height: fit-content;
}
@media screen and (max-width: 1440px) {
  .sidebar-left {
    left: 20px;
  }
}
@media screen and (max-width: 768px) {
  .sidebar-left {
    display: none;
  }
}
.action-btn {
  width: 100%;
  padding: 12px;
  margin-bottom: 10px;
  border: none;
  border-radius: 4px;
  background-color: #f5f7fa;
  cursor: pointer;
  transition: all 0.3s;
  text-align: left;
  display: flex;
  align-items: center;
  gap: 8px;
}
.action-btn:hover {
  background-color: #e4e7ed;
}
</style>

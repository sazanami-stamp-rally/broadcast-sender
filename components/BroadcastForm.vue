<template>
  <form @submit.prevent="handleSubmit" class="bg-white rounded-lg shadow-lg p-6">
    <h2 class="text-xl font-semibold mb-6">アナウンス作成</h2>

    <div class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">ブースID</label>
        <input v-model="form.boothId" type="text" required :disabled="loading"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50">
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">パスコード</label>
        <input v-model="form.passcode" type="password" required :disabled="loading"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50">
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">タイトル</label>
        <input v-model="form.title" type="text" required :disabled="loading"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50">
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">アナウンス内容</label>
        <textarea v-model="form.body" required :disabled="loading" rows="4"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50"></textarea>
      </div>
    </div>

    <button type="submit" :disabled="loading" :class="{ 'opacity-50 cursor-not-allowed': loading }"
      class="w-full mt-6 bg-black text-white py-2 px-4 rounded-md hover:bg-gray-800 transition-colors">
      <span v-if="!loading">アナウンスを送信</span>
      <span v-else class="flex items-center justify-center">
        <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none"
          viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
          </path>
        </svg>
        送信中...
      </span>
    </button>
  </form>
</template>

<script setup lang="ts">
import type { CreateBroadcastRequest } from '~/types/broadcast'

const props = defineProps<{
  confirmDialog: boolean
  confirmData: CreateBroadcastRequest
}>()

const emit = defineEmits(['update:confirmDialog', 'update:confirmData', 'success', 'error']);
const loading = ref(false);
const form = ref({
  boothId: '',
  passcode: '',
  title: '',
  body: ''
});

function handleSubmit() {
  emit('update:confirmData', { ...form.value });
  emit('update:confirmDialog', true);
}

async function submitBroadcast() {
  loading.value = true;

  try {
    const response = await fetch('http://localhost:3000/api/broadcast', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(form.value)
    });

    if (!response.ok) {
      // bodyのmessageが存在する場合、それをthrowする
      const error = await response.json();
      if (error.message) {
        throw new Error(error.message);
      }
      throw new Error('送信に失敗しました。もう一度お試しください。');
    }

    emit('success');
    form.value = {
      ...form.value,
      title: '',
      body: ''
    };
  } catch (e) {
    emit('error', e instanceof Error ? e.message : '予期せぬエラーが発生しました');
  } finally {
    loading.value = false;
  }
}

defineExpose({
  submitBroadcast
});

</script>

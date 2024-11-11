<template>
  <DialogTransition>
    <div v-if="modelValue" class="fixed inset-0 z-50">
      <div 
        v-motion
        :initial="{ opacity: 0 }"
        :enter="{ opacity: 1 }"
        :leave="{ opacity: 0 }"
        class="fixed inset-0 bg-black/50"
      />
      <div class="fixed inset-0 flex items-center justify-center">
        <DialogContainer>
          <h3 class="text-xl font-bold mb-4">送信の確認</h3>
          <p class="text-gray-600 mb-6">以下の内容でアナウンスを送信します。よろしいですか？</p>
          
          <div class="space-y-3 mb-6 text-left">
            <div>
              <div class="text-sm font-medium text-gray-500">タイトル</div>
              <div class="text-gray-900">{{ data.title }}</div>
            </div>
            <div>
              <div class="text-sm font-medium text-gray-500">内容</div>
              <div class="text-gray-900 whitespace-pre-wrap">{{ data.body }}</div>
            </div>
          </div>

          <div class="flex space-x-3">
            <button
              @click="handleConfirm"
              class="flex-1 bg-black text-white px-4 py-2 rounded-md hover:bg-gray-800 transition-colors"
            >
              送信する
            </button>
            <button
              @click="handleCancel"
              class="flex-1 bg-gray-100 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-200 transition-colors"
            >
              キャンセル
            </button>
          </div>
        </DialogContainer>
      </div>
    </div>
  </DialogTransition>
</template>

<script setup lang="ts">
import type { CreateBroadcastRequest } from '~/types/broadcast'

const props = defineProps<{
  modelValue: boolean
  data: CreateBroadcastRequest
}>()

const emit = defineEmits(['update:modelValue', 'confirm', 'cancel'])

function handleConfirm() {
  emit('update:modelValue', false)
  setTimeout(() => emit('confirm'), 300)
}

function handleCancel() {
  emit('update:modelValue', false)
  setTimeout(() => emit('cancel'), 300)
}
</script>
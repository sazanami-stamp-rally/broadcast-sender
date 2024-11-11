<template>
  <div class="min-h-screen bg-gradient-to-b from-blue-50 to-blue-100 flex items-center justify-center p-4">
    <div
      v-motion
      :initial="{ opacity: 0, y: 50 }"
      :enter="{ opacity: 1, y: 0 }"
      class="w-full max-w-md"
    >
      <div class="text-center mb-8">
        <div 
          v-motion
          :initial="{ scale: 0.5 }"
          :enter="{ scale: 1 }"
          class="w-16 h-16 bg-blue-600 rounded-full flex items-center justify-center mx-auto mb-4"
        >
          <span class="text-white text-2xl">📢</span>
        </div>
        <h1 class="text-2xl font-bold text-gray-800">アナウンス配信システム</h1>
        <p class="text-gray-600 mt-2">グループワークのアナウンスを簡単に配信</p>
      </div>

      <BroadcastForm 
        ref="broadcastForm"
        v-model:confirm-dialog="showConfirmDialog"
        v-model:confirm-data="confirmData"
        @success="handleSuccess"
        @error="handleError"
      />
    </div>

    <ConfirmDialog
      v-model="showConfirmDialog"
      :data="confirmData"
      @confirm="handleConfirm"
    />

    <SuccessAnimation
      v-model="showSuccess"
    />

    <ErrorAnimation
      v-model="showError"
      :error-message="errorMessage"
    />
  </div>
</template>

<script setup lang="ts">
import type { CreateBroadcastRequest } from '~/types/broadcast'

const broadcastForm = ref()
const showConfirmDialog = ref(false)
const showSuccess = ref(false)
const showError = ref(false)
const errorMessage = ref('')
const confirmData = ref<CreateBroadcastRequest>({
  boothId: '',
  passcode: '',
  title: '',
  body: ''
})

function handleSuccess() {
  showSuccess.value = true
}

function handleError(message: string) {
  errorMessage.value = message
  showError.value = true
}

async function handleConfirm() {
  showConfirmDialog.value = false
  await broadcastForm.value?.submitBroadcast()
}
</script>
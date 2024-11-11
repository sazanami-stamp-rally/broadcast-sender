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
          <div 
            v-motion
            :initial="{ scale: 0, rotate: -180 }"
            :enter="{
              scale: 1,
              rotate: 0,
              transition: {
                type: 'spring',
                stiffness: 200,
                damping: 12,
                delay: 300
              }
            }"
            class="w-20 h-20 bg-red-500 rounded-full flex items-center justify-center mx-auto mb-4"
          >
            <span 
              v-motion
              :initial="{ opacity: 0, scale: 0 }"
              :enter="{ opacity: 1, scale: 1, transition: { delay: 450 } }"
              class="text-white text-4xl"
            >
              ✕
            </span>
          </div>
          <h3 
            v-motion
            :initial="{ opacity: 0, y: 10 }"
            :enter="{ opacity: 1, y: 0, transition: { delay: 350 } }"
            class="text-xl font-bold mb-2 text-center"
          >
            エラー
          </h3>
          <p 
            v-motion
            :initial="{ opacity: 0, y: 10 }"
            :enter="{ opacity: 1, y: 0, transition: { delay: 400 } }"
            class="text-gray-600 mb-4 text-center"
          >
            {{ errorMessage }}
          </p>
          <button
            v-motion
            :initial="{ opacity: 0, y: 10 }"
            :enter="{ opacity: 1, y: 0, transition: { delay: 450 } }"
            @click="$emit('update:modelValue', false)"
            class="w-full bg-black text-white px-6 py-2 rounded-md hover:bg-gray-800 transition-colors"
          >
            閉じる
          </button>
        </DialogContainer>
      </div>
    </div>
  </DialogTransition>
</template>

<script setup lang="ts">
defineProps<{
  modelValue: boolean
  errorMessage: string
}>()

defineEmits(['update:modelValue'])
</script>
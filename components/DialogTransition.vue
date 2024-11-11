<template>
  <Transition
    enter-active-class="transition-all duration-300 ease-out"
    enter-from-class="opacity-0"
    enter-to-class="opacity-100"
    leave-active-class="transition-all duration-300 ease-in"
    leave-from-class="opacity-100"
    leave-to-class="opacity-0"
    @after-leave="$emit('after-leave')"
  >
    <slot />
  </Transition>
</template>

<script setup lang="ts">
defineEmits(['after-leave'])
</script>
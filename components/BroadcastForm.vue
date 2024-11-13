<template>
  <form @submit.prevent="handleSubmit" class="bg-white rounded-lg shadow-lg p-6">
    <h2 class="text-xl font-semibold mb-6">アナウンス作成</h2>

    <div class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">ブース</label>
        <select v-model="form.boothId" type="text" required :disabled="loading"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50">
          <option value="opening_ceremony">オープニングセレモニー</option>
          <option value="cg_specialist_department_tc_competition_awards">CGスペシャリスト学科 TC コンペ表彰式</option>
          <option value="cosplay_contest_appeal_time">コスプレコンテスト アピールタイム</option>
          <option value="cultural_festival_free_stage">文化祭フリーステージ</option>
          <option value="cosplay_contest_award_ceremony">コスプレコンテスト 表彰式</option>
          <option value="bingo_tournament">ビンゴ大会</option>
          <option value="charity_mochi_pounding_event">チャリティー餅つきイベント</option>
          <option value="happy_music_live_event">HAPPY☆MUSIC ライブイベント</option>
          <option value="baby_castella_shop">ベビーカステラ屋さん</option>
          <option value="popcorn_presented_by_sazanami_development">ポップコーン Presented by さざなみ開発</option>
          <option value="gyoza_no_hirano">餃子の平野</option>
          <option value="yakitori_fugetsu">焼鳥風月（やきとりふうげつ）</option>
          <option value="bird_summit">鳥馬鹿（うちょうてん）</option>
          <option value="spiral_potato">ぐるぐるポテト</option>
          <option value="thirsty_drink_stand">とれいんてぃドリンクスタンド</option>
          <option value="cg_art_exhibition_and_screening">CG作品展示・上映</option>
          <option value="duel_summoners_peak">決闘！召喚の頂</option>
          <option value="sparking_zero_tournament">スパーキングゼロ！大会</option>
          <option value="super_smash_bros_special_game_decisive_battle">大乱闘スマッシュブラザーズ SPECIAL ゲーム最終決定戦</option>
          <option value="street_fighter_6_tournament">ストリートファイター6 トーナメント大会</option>
          <option value="poke_festival">ポケフェスティバス</option>
          <option value="duel_land">デュエランド</option>
          <option value="encyclopedia_king_academy">百科王学園</option>
          <option value="shotgun_roulette">ショットガンルーレット</option>
          <option value="game_and_sip_studio_gs2">Game & Sip Studio (GS^2)</option>
          <option value="maidrink_trident_shop">めいどりんく とらいでんと店</option>
          <option value="retro_game_stadium">レトロゲームスタジアム</option>
          <option value="fun_shooting_gallery">たのしい射的</option>
          <option value="string_lottery">ひもくじ</option>
          <option value="gt_graduation_project_exhibition">GT卒業制作展示</option>
          <option value="game_department_international_exhibition">ゲーム学科国際交流作品展示</option>
          <option value="gamelab_play_space">GameLab::PlaySpace</option>
          <option value="sazanami_development">さざなみ開発</option>
          <option value="puzzle_solving">謎解き</option>
          <option value="game_square">ゲーム広場</option>
          <option value="kicking_sniper">キッキングスナイパー</option>
          <option value="dandelion_and_craftcube">蒲公英 & CRAFTCUBE</option>
          <option value="one_coin_fortune_telling">ワンコイン占い</option>
          <option value="team_print_the">チーム出た印</option>
          <option value="debug_booth_1">デバッグブース1</option>
          <option value="debug_booth_2">デバッグブース2</option>
          <option value="debug_booth_3">デバッグブース3</option>
          <option value="debug_booth_4">デバッグブース4</option>
        </select>
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">パスコード</label>
        <input v-model="form.passcode" type="password" required :disabled="loading"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50">
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">カテゴリ</label>
        <select v-model="form.type" type="text" required :disabled="loading"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50">
          <option value="booth">ブースからの案内</option>
          <option value="booth_important">ブースからのの重要な案内</option>
          <option value="event">セール, 対戦空きなどの案内</option>
          <option value="staff">運営/スタッフからの案内</option> <!-- TODO: v-ifを設けて表示制御 -->
        </select>
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
  type: '',
  title: '',
  body: ''
});

function handleSubmit() {
  emit('update:confirmData', { ...form.value });
  emit('update:confirmDialog', true);
}

async function submitBroadcast() {
  loading.value = true;

  const config = useRuntimeConfig();

  try {
    const response = await fetch(`${config.public.apiUrl}/api/broadcast`, {
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
      type: '',
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

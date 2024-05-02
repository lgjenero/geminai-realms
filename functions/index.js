const fetch = require("node-fetch");
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const {JWT} = require("google-auth-library");
admin.initializeApp();

const REGION = "us-central1";
const PROJECT = "cybernetic-tide-421610";
const MODEL_ID = "gemini-1.0-pro";
const URL = `https://${REGION}-aiplatform.googleapis.com/v1/projects/${PROJECT}/locations/${REGION}/publishers/google/models/${MODEL_ID}:generateContent`;

const getIdToken = async () => {
  const client = new JWT({
    keyFile: "./google.json",
    scopes: ["https://www.googleapis.com/auth/cloud-platform"],
  });
  const idToken = await client.authorize();
  return idToken.access_token;
};

const fantasyRealm = "a medieval, magical, fantasy world filled with dragons," +
  " wizards, sorcerers, elves, orcs, goblins and magic.";
const cyberpunkRealm = "a futuristic world with a cyberpunk theme filled with" +
  " neon lights, advanced technology, hackers, cyborgs, artificial" +
  " intelligence, mega corporations and cybernetic implants.";
const greekRealm = "a fantasy world based on Greek mythology filled with" +
  " gods, goddesses, heroes, monsters, titans, demigods, magic" +
  " and epic quests.";

const fantasyRealmRaceOptions = [
  "elf",
  "dwarf",
  "human",
  "halfling",
  "half-elf",
  "half-orc",
];

const fantasyRealmAgeOptions = [
  "a young",
  "a",
  "an old",
];

const fantasyRealmClassOptions = [
  "wizard",
  "peasant",
  "rogue thief",
  "sorcerer",
  "ranger",
  "warrior",
  "druid",
  "bard",
  "paladin",
  "cleric",
];

const fantasyRealmQuestOptions = [
  "is on a quest to find a powerful artifact that can save the world.",
  "is on a quest to defeat a great evil that threatens the world.",
  "is on a quest to rescue a princess who has been kidnapped by a dragon.",
  "is on a quest to find a lost city that is said to hold great treasure.",
  "is on a quest to find a sword that can only be wielded by a true hero.",
  "is on a quest to find a lost kingdom that has been hidden for centuries.",
  "is on a quest to find a magical amulet that can grant any wish.",
  "is on a quest to find a hidden temple that is said to hold great power.",
  "is on a quest to find a powerful spell that can defeat any enemy.",
  "is on a quest to find their legacy and fulfill their destiny.",
];

const cyberpunkRealmRaceOptions = [
  "human",
  "cyborg",
  "android",
  "robot",
];

const cyberpunkRealmAgeOptions = [
  "young",
  "",
  "old",
];

const cyberpunkRealmClassOptions = [
  "hacker",
  "corporate executive",
  "street samurai",
  "netrunner",
  "fixer",
  "rockerboy",
  "media",
  "nomad",
  "tech",
  "medtech",
];

const cyberpunkRealmQuestOptions = [
  "is on a quest to find a powerful AI that can save the world.",
  "is on a quest to defeat a great corporation that threatens the world.",
  "is on a quest to rescue a scientist who has been kidnapped by a gang.",
  "is on a quest to find a lost city that is said to hold great technology.",
  "is on a quest to find a tech that can save their brother.",
  "is on a quest to find a lost database that has been hidden for centuries.",
  "is on a quest to find a cybernetic implant that can hack anything.",
  "is on a quest to find a hidden server that is said to hold great power.",
  "is on a quest to find a powerful virus that can defeat any enemy.",
];

const greekRealmRaceOptions = [
  "human",
  "demigod",
  "centaur",
  "titan",
  "nymph",
];

const greekRealmAgeOptions = [
  "a young",
  "a",
  "an old",
];

const greekRealmClassOptions = [
  "warrior",
  "philosopher",
  "mage",
  "barbarian",
  "priest",
];

const greekRealmQuestOptions = [
  "is on a quest to find a powerful artifact that can save the world.",
  "is on a quest to defeat a great evil that threatens the world.",
  "is on a quest to rescue a princess who has been kidnapped by a monster.",
  "is on a quest to find a lost city that is said to hold great treasure.",
  "is on a quest to find a sword that can only be wielded by a true hero.",
  "is on a quest to find a lost kingdom that has been hidden for centuries.",
  "is on a quest to find a magical amulet that can grant any wish.",
  "is on a quest to find a hidden temple that is said to hold great power.",
  "is on a quest to find a powerful spell that can defeat any enemy.",
  "is on a quest to find their legacy and fulfill their destiny.",
];

const storyLength = {
  "short": 3,
  "medium": 6,
  "long": 10,
};

const storyChapters = {
  "short": {
    1: "This chapter is the beginning of the story. Charater is trying to" +
      " find more information about the quest, gather more resources and" +
      " prepare for the journey.",
    2: "This chapter is the middle of the story. Charater is on the journey," +
      " facing challenges, meeting new people and discovering new places.",
    3: "This chapter is the end of the story. Charater is facing the final" +
      " challenge, fighting the main enemy and completing the quest.",
  },
  "medium": {
    1: "This chapter is the beginning of the story. Charater is trying to" +
      " find more information about the quest, gather more resources and" +
      " prepare for the journey.",
    2: "This chapter is the beginning of the story. Charater is starting" +
      " the journey, gathering few last pieces of information and resources.",
    3: "This chapter is the middle of the story. Charater is on the journey," +
      " facing challenges, meeting new people and discovering new places.",
    4: "This chapter is the middle of the story. Charater is on the journey," +
      " facing challenges, meeting new people and discovering new places.",
    5: "This chapter is the begining of the end of the story. Charater is" +
      " getting closer to the final challenge.",
    6: "This chapter is the end of the story. Charater is facing the final" +
      " challenge, fighting the main enemy and completing the quest.",
  },
  "long": {
    1: "This chapter is the beginning of the story. Charater is trying to" +
      " find  more information about the quest, gather more resources and" +
      " prepare for the journey.",
    2: "This chapter is the beginning of the story. Charater is starting" +
      " the journey, gathering few lst pieces of information and resources.",
    3: "This chapter is the early in the story. Charater started the journey," +
      " you can feel optimism and hope.",
    4: "This chapter is the early in the story. Charater on the journey and" +
      " is starting to face lighter challenges.",
    5: "This chapter is the middle of the story. Charater is on the journey," +
      " facing challenges, meeting new people and discovering new places.",
    6: "This chapter is the middle of the story. Charater is on the journey," +
      " facing a bit harder challenges, some of the people are unfriendly," +
      " some of the places are unfriendly.",
    7: "This chapter is the middle of the story. Charater is on the journey," +
      " facing a bit harder challenges, the .",
    8: "This chapter is the begining of the end of the story. Charater is" +
      " getting closer to the final challenge.",
    9: "This chapter is setting the end of the story. Before the final" +
      " challenge, character is facing the last obstacle.",
    10: "This chapter is the end of the story. Charater is facing the final" +
      " challenge, fighting the main enemy and completing the quest.",
  },
};

const CHAPTER_EVENT_NUM = 10;

const getStory = async (realm) => {
  const headers = {
    "Authorization": `Bearer ` + (await getIdToken()),
    "Content-Type": "application/json",
  };

  let realmDescription = fantasyRealm;
  let classOptions = fantasyRealmClassOptions;
  let raceOptions = fantasyRealmRaceOptions;
  let ageOptions = fantasyRealmAgeOptions;
  let questOptions = fantasyRealmQuestOptions;
  if (realm === "cyberpunk") {
    realmDescription = cyberpunkRealm;
    classOptions = cyberpunkRealmClassOptions;
    raceOptions = cyberpunkRealmRaceOptions;
    ageOptions = cyberpunkRealmAgeOptions;
    questOptions = cyberpunkRealmQuestOptions;
  } else if (realm === "greek") {
    realmDescription = greekRealm;
    classOptions = greekRealmClassOptions;
    raceOptions = greekRealmRaceOptions;
    ageOptions = greekRealmAgeOptions;
    questOptions = greekRealmQuestOptions;
  }

  const clazz = classOptions[Math.floor(Math.random() * classOptions.length)];
  const race = raceOptions[Math.floor(Math.random() * raceOptions.length)];
  const age = ageOptions[Math.floor(Math.random() * ageOptions.length)];
  const quest = questOptions[Math.floor(Math.random() * questOptions.length)];

  const character = `main character who is ${age} ${clazz}` +
    ` ${race} who ${quest}`;

  const data = {
    "contents": {
      "role": "user",
      "parts": {
        "text": "Create an adventure game story based on a world" +
          ` set in ${realmDescription} with the ${character}`,
      },
    },
    "system_instruction": {
      "parts": {
        "text": "respond in a JSON format with these mandatory fields:\n" +
          " 1) world: Describe the game world in a few sentences.\n" +
          " 2) character: Describe the main character in a few sentences.\n" +
          " 3) intro: Describe how the game starts in a few sentences.",
      },
    },
    "safety_settings": {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE",
    },
    "generation_config": {
      "temperature": 1.0,
      "topP": 1.0,
      "topK": 40,
    },
  };

  const response = await fetch(URL, {
    method: "POST",
    headers,
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    console.error(response.status);
    console.error(response.statusText);
    console.error(JSON.stringify(response.json()));
    throw new Error("Request failed " + response.statusText);
  }

  const result = await response.json();

  const text = result.candidates[0].content.parts[0].text;
  const sanitisedText =
    text ? text.replace("```json", "").replaceAll("`", "").trim() : null;
  const responseData = JSON.parse(sanitisedText);

  console.log("World: ", responseData.world);
  console.log("Character: ", responseData.character);
  console.log("Intro: ", responseData.intro);

  return {
    world: responseData.world,
    character: responseData.character,
    intro: responseData.intro,
  };
};

const getChapter = async (story, length, chapter) => {
  const headers = {
    "Authorization": `Bearer ` + (await getIdToken()),
    "Content-Type": "application/json",
  };

  const chapterCount = storyLength[length];
  const chapterData = storyChapters[length][chapter];

  const data = {
    "contents": {
      "role": "user",
      "parts": {
        "text": `The game story is as follows: ${story}\n` +
          "Create the next chapter of the story." +
          ` Each story can have around ${chapterCount} chapters. ` +
          chapterData,
      },
    },
    "system_instruction": {
      "parts": {
        "text": "respond in a JSON format with these mandatory fields:" +
          "summary: Short description of what happens in the chapter.\n" +
          "intro: Short introduction to the chapter.\n" +
          "Make the JSON valid and do not add comments",
      },
    },
    "safety_settings": {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_LOW_AND_ABOVE",
    },
    "generation_config": {
      "temperature": 1.0,
      "topP": 1.0,
      "topK": 40,
    },
  };


  const response = await fetch(URL, {
    method: "POST",
    headers,
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    console.error(response.statusText);
    console.error(JSON.stringify(response.json()));
    throw new Error("Request failed " + response.statusText);
  }

  const result = await response.json();

  const text = result.candidates[0].content.parts[0].text;
  const sanitisedText =
    text ? text.replace("```json", "").replaceAll("`", "").trim() : null;
  const responseData = JSON.parse(sanitisedText);

  console.log("location: ", responseData.location);
  console.log("situation: ", responseData.situation);
  console.log("summary: ", responseData.summary);
  console.log("intro: ", responseData.intro);

  return {
    location: responseData.location,
    situation: responseData.situation,
    summary: responseData.summary,
    intro: responseData.intro,
  };
};

const getChapterEvent = async (story, length, chapter, event) => {
  const headers = {
    "Authorization": `Bearer ` + (await getIdToken()),
    "Content-Type": "application/json",
  };

  const data = {
    "contents": {
      "role": "user",
      "parts": {
        "text": `The game story is as follows: ${story}\n` +
          `Create next event of the story chapter.` +
          " Event should be a call for action for the main character." +
          ` Each chapter can have up to ${CHAPTER_EVENT_NUM} events.`,
      },
    },
    "system_instruction": {
      "parts": {
        "text": "respond in a JSON format with these mandatory fields:\n" +
          "call_for_action: Short but detailed description of what" +
          " happened that requires the main character to decide on an" +
          " action.\n" +
          "action_options: List possible actions the main charater" +
          " can take. Each option maximum 150 characters.\n" +
          "action_options_probability: List probablity of success" +
          " for each possible actions in action_options." +
          " Values are between 0 and 1.\n" +
          " Make the JSON valid and do not add comments",
      },
    },
    "safety_settings": {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_LOW_AND_ABOVE",
    },
    "generation_config": {
      "temperature": 1.0,
      "topP": 1.0,
      "topK": 40,
    },
  };


  const response = await fetch(URL, {
    method: "POST",
    headers,
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    console.error(response.statusText);
    console.error(JSON.stringify(response.json()));
    throw new Error("Request failed " + response.statusText);
  }

  const result = await response.json();

  const text = result.candidates[0].content.parts[0].text;
  const sanitisedText =
    text ? text.replace("```json", "").replaceAll("`", "").trim() : null;
  const responseData = JSON.parse(sanitisedText);

  console.log("call_for_action: ", responseData.call_for_action);
  console.log("action_options: ", responseData.action_options);
  console.log(
      "action_options_probability: ",
      responseData.action_options_probability,
  );

  return {
    call_for_action: responseData.call_for_action,
    action_options: responseData.action_options,
    action_options_probability: responseData.action_options_probability,
  };
};

const getChapterEventResult = async (story, length, chapter, event) => {
  const headers = {
    "Authorization": `Bearer ` + (await getIdToken()),
    "Content-Type": "application/json",
  };

  const data = {
    "contents": {
      "role": "user",
      "parts": {
        "text": `The game story is as follows: ${story}\n` +
          `Create result of the last event action in the chapter.` +
          ` Each chapter can have up to ${CHAPTER_EVENT_NUM} events.` +
          " If all events are done, finish the chapter.",
      },
    },
    "system_instruction": {
      "parts": {
        "text": "respond in a JSON format with these fields:\n" +
          "description: Short description of what happened as the" +
          " result of the characters action considering the" +
          " success if the action. Field is mandatory.\n" +
          "chapter_ended: Does this action end the current" +
          " story chapter. Field is type boolean and optional.\n" +
          "character_died: Did the main character die as the" +
          " result of this action. Field is type boolean and optional.\n" +
          " Make the JSON valid and do not add comments",
      },
    },
    "safety_settings": {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_LOW_AND_ABOVE",
    },
    "generation_config": {
      "temperature": 1.0,
      "topP": 1.0,
      "topK": 40,
    },
  };


  const response = await fetch(URL, {
    method: "POST",
    headers,
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    console.error(response.statusText);
    console.error(JSON.stringify(response.json()));
    throw new Error("Request failed " + response.statusText);
  }

  const result = await response.json();

  console.log(JSON.stringify(result));

  const text = result.candidates[0].content.parts[0].text;
  const sanitisedText =
    text ? text.replace("```json", "").replaceAll("`", "").trim() : null;
  const responseData = JSON.parse(sanitisedText);

  console.log("description: ", responseData.description);
  console.log("chapter_ended: ", responseData.chapter_ended);
  console.log("character_died: ", responseData.character_died);

  return {
    description: responseData.description,
    chapter_ended: responseData.chapter_ended,
    character_died: responseData.character_died,
  };
};

const getChapterFinish = async (story, length, chapter) => {
  const headers = {
    "Authorization": `Bearer ` + (await getIdToken()),
    "Content-Type": "application/json",
  };

  const chapterCount = storyLength[length];

  const data = {
    "contents": {
      "role": "user",
      "parts": {
        "text": `The game story is as follows: ${story}\n` +
          "Finish the chapter of the story." +
          ` Keep in mind each story has ${chapterCount} chapters.`,
      },
    },
    "system_instruction": {
      "parts": {
        "text": "respond in a JSON format with these fields:\n" +
          "chapter_end: Short paragraph finishing the last chapter." +
          " This field is mandatory.\n" +
          "compressed_chapter: Short paragraph summarizing the last" +
          " chapter that includes all the important details that happend." +
          " This field is mandatory.\n" +
          "game_over: Is the game over, was this the last chapter." +
          " This field is type boolean and optional.\n" +
          " Make the JSON valid and do not add comments",
      },
    },
    "safety_settings": {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_LOW_AND_ABOVE",
    },
    "generation_config": {
      "temperature": 1.0,
      "topP": 1.0,
      "topK": 40,
    },
  };


  const response = await fetch(URL, {
    method: "POST",
    headers,
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    console.error(response.statusText);
    console.error(JSON.stringify(response.json()));
    throw new Error("Request failed " + response.statusText);
  }

  const result = await response.json();

  console.log(JSON.stringify(result));

  const text = result.candidates[0].content.parts[0].text;
  const sanitisedText =
    text ? text.replace("```json", "").replaceAll("`", "").trim() : null;
  const responseData = JSON.parse(sanitisedText);

  console.log("chapter_end: ", responseData.chapter_end);
  console.log("compressed_chapter: ", responseData.compressed_chapter);
  console.log("game_over: ", responseData.game_over);

  return {
    chapter_end: responseData.chapter_end,
    compressed_chapter: responseData.compressed_chapter,
    game_over: responseData.game_over,
  };
};

// Create a new story
exports.createIntro = functions.https.onCall(async (data, context) => {
  try {
    const userId = context.auth.uid;
    if (userId === undefined || userId === null || userId === "") {
      return {message: "User not authenticated", code: 401};
    }

    const realm = data.realm;
    const story = await getStory(realm);

    return {message: "Intro created", code: 200, data: story};
  } catch (error) {
    return {message: `Error creating intro: ${error}`, code: 500};
  }
});

// Create a new section of the story
exports.createChapter = functions.https.onCall(async (data, context) => {
  try {
    const userId = context.auth.uid;
    if (userId === undefined || userId === null || userId === "") {
      return {message: "User not authenticated", code: 401};
    }

    const story = data.story;
    const length = data.length;
    const chapter = data.chapter;
    const chapterData = await getChapter(story, length, chapter);

    return {message: "Chapter created", code: 200, data: chapterData};
  } catch (error) {
    return {message: `Error creating chapter: ${error}`, code: 500};
  }
});

// Create a new chapter event of the story
exports.createChapterEvent = functions.https.onCall(async (data, context) => {
  try {
    const userId = context.auth.uid;
    if (userId === undefined || userId === null || userId === "") {
      return {message: "User not authenticated", code: 401};
    }

    const story = data.story;
    const length = data.length;
    const chapter = data.chapter;
    const event = data.event;
    const chapterEvent = await getChapterEvent(story, length, chapter, event);

    return {message: "Chapter event created", code: 200, data: chapterEvent};
  } catch (error) {
    return {message: `Error creating chapter event: ${error}`, code: 500};
  }
});

// Create a result of the chapter event
exports.createChapterEventResult = functions.https.onCall(
    async (data, context) => {
      try {
        const userId = context.auth.uid;
        if (userId === undefined || userId === null || userId === "") {
          return {message: "User not authenticated", code: 401};
        }

        const story = data.story;
        const length = data.length;
        const chapter = data.chapter;
        const event = data.event;
        const chapterEventResult =
        await getChapterEventResult(story, length, chapter, event);

        return {
          message: "Chapter event result created",
          code: 200,
          data: chapterEventResult,
        };
      } catch (error) {
        return {
          message: `Error creating chapter event result: ${error}`, code: 500,
        };
      }
    });

// Finish the chapter
exports.createChapterFinish = functions.https.onCall(
    async (data, context) => {
      try {
        const userId = context.auth.uid;
        if (userId === undefined || userId === null || userId === "") {
          return {message: "User not authenticated", code: 401};
        }

        const story = data.story;
        const length = data.length;
        const chapter = data.chapter;
        const chapterFinish = await getChapterFinish(story, length, chapter);

        return {
          message: "Chapter finish created",
          code: 200,
          data: chapterFinish,
        };
      } catch (error) {
        return {
          message: `Error creating chapter finish: ${error}`, code: 500,
        };
      }
    });

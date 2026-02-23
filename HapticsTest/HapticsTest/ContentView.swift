import SwiftUI
import SwiftfulHaptics

struct ContentView: View {

    let hapticManager = HapticManager()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                hapticSection("Basic", haptics: [
                    ("selection", .selection),
                    ("soft", .soft),
                    ("rigid", .rigid),
                    ("light", .light),
                    ("medium", .medium),
                    ("heavy", .heavy),
                    ("success", .success),
                    ("error", .error),
                    ("warning", .warning),
                ])

                hapticSection("Gaming", haptics: [
                    ("lightningStrikeQuick", .lightningStrikeQuick()),
                    ("lightningStrikeChain", .lightningStrikeChain()),
                    ("lightningStrikeHeavy", .lightningStrikeHeavy()),
                    ("coinCollectSingle", .coinCollectSingle()),
                    ("coinCollectMulti", .coinCollectMulti()),
                    ("coinCollectJackpot", .coinCollectJackpot()),
                    ("swordSlashLight", .swordSlashLight()),
                    ("swordSlashHeavy", .swordSlashHeavy()),
                    ("arrowRelease", .arrowRelease()),
                    ("explosionSmall", .explosionSmall()),
                    ("explosionMassive", .explosionMassive()),
                    ("shieldBlock", .shieldBlock()),
                    ("criticalHit", .criticalHit()),
                    ("comboHit3x", .comboHit3x()),
                    ("comboHit5x", .comboHit5x()),
                    ("footstepGrass", .footstepGrass()),
                    ("footstepMetal", .footstepMetal()),
                    ("engineStart", .engineStart()),
                    ("turboBoost", .turboBoost()),
                    ("portalEnter", .portalEnter()),
                    ("magicCharge", .magicCharge()),
                    ("machineGun", .machineGun()),
                    ("drums", .drums),
                    ("cascade", .cascade()),
                    ("elasticBounce", .elasticBounce()),
                ])

                hapticSection("Achievements", haptics: [
                    ("achievementUnlocked", .achievementUnlocked()),
                    ("levelUp", .levelUp()),
                    ("starRating", .starRating()),
                    ("badgeEarned", .badgeEarned()),
                    ("streakMilestone", .streakMilestone()),
                    ("perfectScore", .perfectScore()),
                    ("rankPromotion", .rankPromotion()),
                    ("dailyGoalComplete", .dailyGoalComplete()),
                    ("trophyUnlock", .trophyUnlock()),
                    ("questComplete", .questComplete()),
                    ("highScore", .highScore()),
                    ("masteryAchieved", .masteryAchieved()),
                    ("celebrationBurst", .celebrationBurst()),
                    ("ascendingSuccess", .ascendingSuccess()),
                ])

                hapticSection("Learning Feedback", haptics: [
                    ("correctAnswer", .correctAnswer()),
                    ("correctAnswerBasic", .correctAnswerBasic()),
                    ("correctAnswerSimple", .correctAnswerSimple()),
                    ("correctAnswerStreak", .correctAnswerStreak()),
                    ("correctAnswerPerfect", .correctAnswerPerfect()),
                    ("perfectLessonComplete", .perfectLessonComplete()),
                    ("incorrectGentle", .incorrectGentle()),
                    ("wrongAnswerGentle", .wrongAnswerGentle()),
                    ("wrongAnswerStandard", .wrongAnswerStandard()),
                    ("nearMissAnswer", .nearMissAnswer()),
                    ("grammarError", .grammarError()),
                    ("hintAvailable", .hintAvailable()),
                    ("hintActivation", .hintActivation()),
                    ("hintReveal", .hintReveal()),
                    ("progressCheckpoint", .progressCheckpoint()),
                    ("encouragementTap", .encouragementTap()),
                    ("skillUnlocked", .skillUnlocked()),
                    ("lessonComplete", .lessonComplete()),
                    ("practiceReminder", .practiceReminder()),
                    ("knowledgeGained", .knowledgeGained()),
                    ("feedbackPositive", .feedbackPositive()),
                    ("timeCriticalWarning", .timeCriticalWarning()),
                    ("partialCredit", .partialCredit()),
                    ("tryAgainEncouragement", .tryAgainEncouragement()),
                    ("learningProgress", .learningProgress()),
                    ("educationalFocusReminder", .educationalFocusReminder()),
                    ("flashcardFlip", .flashcardFlip()),
                    ("quizStart", .quizStart()),
                ])

                hapticSection("Gamification", haptics: [
                    ("xpGainSmall", .xpGainSmall()),
                    ("xpGainLarge", .xpGainLarge()),
                    ("xpGainBonus", .xpGainBonus()),
                    ("xpGainDynamic", .xpGainDynamic(xpAmount: 30)),
                    ("bonusPoints", .bonusPoints()),
                    ("powerUpCollected", .powerUpCollected()),
                    ("lifeGained", .lifeGained()),
                    ("challengeAccepted", .challengeAccepted()),
                    ("timerTick", .timerTick()),
                    ("rewardUnlock", .rewardUnlock()),
                    ("progressBarFill", .progressBarFill()),
                    ("progressBarFilling", .progressBarFilling(startPercent: 0.0, endPercent: 1.0)),
                    ("progress25", .progress25()),
                    ("progress50", .progress50()),
                    ("progress75", .progress75()),
                    ("dailyGoalCheckpoint", .dailyGoalCheckpoint(checkpointNumber: 1)),
                    ("leagueAdvancement", .leagueAdvancement()),
                    ("crownGemCollection", .crownGemCollection()),
                    ("comboMultiplier", .comboMultiplier()),
                    ("streakRiskWarning", .streakRiskWarning()),
                    ("streakLost", .streakLost()),
                    ("streakBuilding", .streakBuilding(streakCount: 5)),
                    ("streakMilestone5", .streakMilestone5()),
                    ("streakMilestone7Days", .streakMilestone7Days()),
                    ("streakMilestone10", .streakMilestone10()),
                    ("streakMilestone25", .streakMilestone25()),
                    ("streakMilestone30Days", .streakMilestone30Days()),
                    ("streakMilestone100Days", .streakMilestone100Days()),
                    ("badgeUnlock", .badgeUnlock()),
                    ("skillMastery", .skillMastery()),
                    ("leaguePromotion", .leaguePromotion()),
                ])

                hapticSection("UI - Social", haptics: [
                    ("doubleTapLike", .doubleTapLike()),
                    ("messageSent", .messageSent()),
                    ("notificationPop", .notificationPop()),
                    ("typingIndicator", .typingIndicator()),
                    ("commentPosted", .commentPosted()),
                ])

                hapticSection("UI - Navigation", haptics: [
                    ("pullToRefresh", .pullToRefresh()),
                    ("swipeAction", .swipeAction()),
                    ("toggleSwitch", .toggleSwitch()),
                    ("pickerDetent", .pickerDetent()),
                    ("longPressActivation", .longPressActivation()),
                    ("tabSelection", .tabSelection()),
                    ("navigationPush", .navigationPush()),
                    ("navigationPop", .navigationPop()),
                    ("modalPresent", .modalPresent()),
                    ("modalDismiss", .modalDismiss()),
                ])

                hapticSection("UI - Input & Controls", haptics: [
                    ("keyboardTap", .keyboardTap()),
                    ("sliderStep", .sliderStep()),
                    ("sliderTick", .sliderTick()),
                    ("buttonPress", .buttonPress()),
                    ("selectionTick", .selectionTick()),
                    ("segmentChange", .segmentChange()),
                    ("zoomBoundary", .zoomBoundary()),
                    ("dragAndDrop", .dragAndDrop()),
                    ("formSubmit", .formSubmit()),
                    ("inputError", .inputError()),
                    ("loadingComplete", .loadingComplete()),
                    ("appIconTap", .appIconTap()),
                ])

                hapticSection("UI - Additional", haptics: [
                    ("scrollBounce", .scrollBounce()),
                    ("pageFlip", .pageFlip()),
                    ("photoCapture", .photoCapture()),
                    ("shareAction", .shareAction()),
                    ("downloadComplete", .downloadComplete()),
                    ("refreshData", .refreshData()),
                    ("gestureRecognized", .gestureRecognized()),
                    ("pageTurn", .pageTurn()),
                    ("bookPageTurn", .bookPageTurn()),
                    ("softTick", .softTick()),
                    ("customPop", .customPop()),
                    ("contextualMenu", .contextualMenu()),
                    ("sliderValueChange", .sliderValueChange()),
                    ("pop", .pop()),
                ])

                hapticSection("Special Effects", haptics: [
                    ("magicSparkle", .magicSparkle()),
                    ("waterDrop", .waterDrop()),
                    ("specialEarthquake", .specialEarthquake()),
                    ("laserBeam", .laserBeam()),
                    ("typewriter", .typewriter()),
                    ("heartbeat", .heartbeat()),
                    ("electricSpark", .electricSpark()),
                    ("rubberBand", .rubberBand()),
                    ("buildUp", .buildUp()),
                    ("boing", .boing()),
                    ("inflate", .inflate()),
                    ("oscillate", .oscillate()),
                ])

                hapticSection("Wellness", haptics: [
                    ("breathingGuide", .breathingGuide()),
                    ("calmPulse", .calmPulse()),
                    ("meditationBell", .meditationBell()),
                    ("relaxationWave", .relaxationWave()),
                    ("zenNotification", .zenNotification()),
                    ("timeWarning30s", .timeWarning30s()),
                    ("timeWarning10s", .timeWarning10s()),
                    ("heartBeats", .heartBeats()),
                ])

                hapticSection("Productivity", haptics: [
                    ("timerComplete", .timerComplete()),
                    ("taskCheck", .taskCheck()),
                    ("focusStart", .focusStart()),
                    ("breakReminder", .breakReminder()),
                    ("productivityFocusReminder", .productivityFocusReminder()),
                ])

                hapticSection("Finance", haptics: [
                    ("paymentSuccess", .paymentSuccess()),
                    ("paymentProcessing", .paymentProcessing()),
                    ("transactionAlert", .transactionAlert()),
                    ("receiptSaved", .receiptSaved()),
                ])

                hapticSection("Emotional", haptics: [
                    ("excitementBuild", .excitementBuild()),
                    ("disappointment", .disappointment()),
                    ("surprise", .surprise()),
                    ("joy", .joy()),
                    ("anticipation", .anticipation()),
                ])

                hapticSection("Intense - Elemental", haptics: [
                    ("fireBurst", .fireBurst()),
                    ("iceShard", .iceShard()),
                    ("earthquakeRumble", .earthquakeRumble()),
                    ("windTornado", .windTornado()),
                    ("thunderStorm", .thunderStorm()),
                    ("meteorImpact", .meteorImpact()),
                    ("intenseEarthquake", .intenseEarthquake()),
                    ("intenseTornado", .intenseTornado()),
                ])

                hapticSection("Intense - Space & Sci-Fi", haptics: [
                    ("plasmaCharge", .plasmaCharge()),
                    ("gravityWell", .gravityWell()),
                    ("photonBlast", .photonBlast()),
                    ("quantumShift", .quantumShift()),
                    ("rocketLaunch", .rocketLaunch()),
                    ("warpDrive", .warpDrive()),
                    ("laserCannon", .laserCannon()),
                    ("alienTeleport", .alienTeleport()),
                    ("spaceExplosion", .spaceExplosion()),
                ])

                hapticSection("Intense - Epic Abilities", haptics: [
                    ("ultimatePower", .ultimatePower()),
                    ("dragonRoar", .dragonRoar()),
                    ("titanSmash", .titanSmash()),
                    ("dimensionalRift", .dimensionalRift()),
                    ("volcanicEruption", .volcanicEruption()),
                    ("titanStomp", .titanStomp()),
                    ("phoenixRebirth", .phoenixRebirth()),
                    ("divineIntervention", .divineIntervention()),
                ])

                hapticSection("Intense - Power-ups", haptics: [
                    ("megaBoost", .megaBoost()),
                    ("starPower", .starPower()),
                    ("berserkerRage", .berserkerRage()),
                    ("divineShield", .divineShield()),
                    ("invincibilityActivation", .invincibilityActivation()),
                    ("timeFreeze", .timeFreeze()),
                    ("ultraCombo", .ultraCombo()),
                    ("nuclearCharge", .nuclearCharge()),
                ])

                hapticSection("Ratings & Feedback", haptics: [
                    ("starRating1", .starRating1()),
                    ("starRating3", .starRating3()),
                    ("starRating5", .starRating5()),
                ])

                hapticSection("Tools & Writing", haptics: [
                    ("pencilWrite", .pencilWrite()),
                    ("eraserUse", .eraserUse()),
                ])
            }
            .padding()
        }
        .navigationTitle("Haptics")
    }

    @ViewBuilder
    func hapticSection(_ title: String, haptics: [(String, HapticOption)]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100), spacing: 8)
            ], spacing: 8) {
                ForEach(haptics, id: \.0) { name, option in
                    Button {
                        hapticManager.playHaptic(option: option)
                    } label: {
                        Text(name)
                            .font(.caption)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

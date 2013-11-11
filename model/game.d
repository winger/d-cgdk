module model.game;

import model.trooper;

class Game {
    immutable int moveCount;
    immutable int lastPlayerEliminationScore;
    immutable int playerEliminationScore;
    immutable int trooperEliminationScore;
    immutable double trooperDamageScoreFactor;
    immutable int stanceChangeCost;
    immutable int[TrooperStance.max + 1] moveCost;
    immutable int commanderAuraBonusActionPoints;
    immutable double commanderAuraRange;
    immutable int fieldMedicHealCost;
    immutable int fieldMedicHealBonusHitpoints;
    immutable int fieldMedicHealSelfBonusHitpoints;
    immutable int commanderRequestEnemyDispositionCost;
    immutable int commanderRequestEnemyDispositionMaxOffset;
    immutable double[TrooperStance.max + 1] sniperStealthBonus;
    immutable double[TrooperStance.max + 1] sniperShootingRangeBonus;
    immutable double scoutStealthBonusNegation;
    immutable int grenadeThrowCost;
    immutable double grenadeThrowRange;
    immutable int grenadeDirectDamage;
    immutable int grenadeCollateralDamage;
    immutable int medikitUseCost;
    immutable int medikitBonusHitpoints;
    immutable int medikitHealSelfBonusHitpoints;
    immutable int fieldRationEatCost;
    immutable int fieldRationBonusActionPoints;

    this(int moveCount,
        int lastPlayerEliminationScore, int playerEliminationScore,
        int trooperEliminationScore, double trooperDamageScoreFactor,
        int stanceChangeCost, immutable int[TrooperStance.max + 1] moveCost,
        int commanderAuraBonusActionPoints, double commanderAuraRange,
        int fieldMedicHealCost, int fieldMedicHealBonusHitpoints, int fieldMedicHealSelfBonusHitpoints,
        int commanderRequestEnemyDispositionCost, int commanderRequestEnemyDispositionMaxOffset,
        immutable double[TrooperStance.max + 1] sniperStealthBonus,
        immutable double[TrooperStance.max + 1] sniperShootingRangeBonus, double scoutStealthBonusNegation,
        int grenadeThrowCost, double grenadeThrowRange, int grenadeDirectDamage, int grenadeCollateralDamage,
        int medikitUseCost, int medikitBonusHitpoints, int medikitHealSelfBonusHitpoints,
        int fieldRationEatCost, int fieldRationBonusActionPoints) {
    	this.moveCount = moveCount;
    	this.lastPlayerEliminationScore = lastPlayerEliminationScore;
    	this.playerEliminationScore = playerEliminationScore;
    	this.trooperEliminationScore = trooperEliminationScore;
    	this.trooperDamageScoreFactor = trooperDamageScoreFactor;
    	this.stanceChangeCost = stanceChangeCost;
    	this.moveCost = moveCost;
    	this.commanderAuraBonusActionPoints = commanderAuraBonusActionPoints;
    	this.commanderAuraRange = commanderAuraRange;
    	this.fieldMedicHealCost = fieldMedicHealCost;
    	this.fieldMedicHealBonusHitpoints = fieldMedicHealBonusHitpoints;
    	this.fieldMedicHealSelfBonusHitpoints = fieldMedicHealSelfBonusHitpoints;
    	this.commanderRequestEnemyDispositionCost = commanderRequestEnemyDispositionCost;
    	this.commanderRequestEnemyDispositionMaxOffset = commanderRequestEnemyDispositionMaxOffset;
    	this.sniperStealthBonus = sniperStealthBonus;
    	this.sniperShootingRangeBonus = sniperShootingRangeBonus;
    	this.scoutStealthBonusNegation = scoutStealthBonusNegation;
    	this.grenadeThrowCost = grenadeThrowCost;
    	this.grenadeThrowRange = grenadeThrowRange;
    	this.grenadeDirectDamage = grenadeDirectDamage;
    	this.grenadeCollateralDamage = grenadeCollateralDamage;
    	this.medikitUseCost = medikitUseCost;
    	this.medikitBonusHitpoints = medikitBonusHitpoints;
    	this.medikitHealSelfBonusHitpoints = medikitHealSelfBonusHitpoints;
    	this.fieldRationEatCost = fieldRationEatCost;
    	this.fieldRationBonusActionPoints = fieldRationBonusActionPoints;
	}
}
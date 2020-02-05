class X2Ability_AdditionalAP extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateAdditionalAPAbility());

	return Templates;
}

static function X2AbilityTemplate CreateAdditionalAPAbility()
{
	local X2AbilityTemplate Template;
	local X2Effect_AdditionalAP ActionPointEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'InitialAP');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_adventstunlancer_charge";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.bDontDisplayInAbilitySummary = true;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_UnitPostBeginPlay');

	ActionPointEffect = new class'X2Effect_AdditionalAP';
	ActionPointEffect.BuildPersistentEffect(1, true, true, true);
	ActionPointEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true);
	ActionPointEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(ActionPointEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.bSkipFireAction = true;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@OData.hierarchy.recursiveHierarchy: [{ entity.name: 'Zhh_I_DMOTreeTeamHR' }]
define root view entity ZHH_C_DMOTreeTeam
  provider contract transactional_query
  as projection on ZHH_R_DMOTreeTeam
  association of many to one ZHH_C_DMOTreeTeam as _TeamLeader on $projection.TeamLeader = _TeamLeader.UserId
{
  key UserId,
  PlayerName,
  PlayerEmail,
  PlayerPosition,
  Score,
  Team,
  TeamLeader,
  LocalCreatedBy,
  LocalLastChangedBy,
  LocalLastChanged,
  LastChanged,
  
  _TeamLeader
  
}

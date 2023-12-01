export const UserRelation = {
    user: ['user_id', 
    'surname', 
    'forname', 
    'localNumber', 
    'telephone', 
    'email', 
    'jobId', 
    'departmentId', 
    'locationId', 
    'registrationDate', 
    'lastLoginDate', 
    'status', 
    'code', 
    'gender'],
      subbmitet:{
        relation: 'subbmited',
        select: ['user_id', 'surname', 'forname', 'localNumber', 'telephone', 'email', 'jobId', 'departmentId', 'locationId', 'registrationDate', 'lastLoginDate', 'status', 'code', 'gender'],
      }
}
# Get csv files into a data frames.
training_set <- read.csv("data/census_income_learn.csv", header=FALSE)
testing_set <- read.csv("data/census_income_test.csv", header=FALSE, quote="")
attributes_names <- c('Age', 'Worker.class', 'Industry.code', 'Occupation.code',
                      'Education', 'Wage', 'Enroll.education', 'Marital.status',
                      'MajorIndustry.code', 'MajorOccupation.code', 'Race', 'Hispanic.origin',
                      'Sex', 'LaborUnion', 'Unemployment.reason', 'Employment.stat',
                      'Capital.gains', 'Capital.losses', 'Dividends', 'Tax', 'Residence.region',
                      'Residence.state', 'Family.stat', 'Household.summary', 'Instance.weight',
                      'Migration.codeInmsa', 'Migration.codeInreg', 'Migration.codeWithinreg',
                      'LiveSince1Year', 'Migration.prevSunbelt', 'Persons.worked', 'FamilyUnder18',
                      'Father.country', 'Mother.coutry', 'Self.country', 'Citizenship', 'Business.types',
                      'FilQuestionnaire', 'VeteransBenefits', 'Weeks.workedPerYear', 'Year')
class_names <- c(' - 50000.', ' 50000+.')
colnames(training_set) <- c(attributes_names, 'Gain')
colnames(testing_set) <- c(attributes_names, 'Gain')

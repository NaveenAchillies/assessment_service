# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(:email => 'test_user@test.com' , :password => 'password' , :password_confirmation => 'password')
exam = Exam.create(:name=>'test1')
subjects = exam.subjects.create([{:title=>"Biology"},{:title=>"Chemistry"},{:title=>"Maths"}])
topics = subjects[0].topics.create([{:title=>"Diversity of Living Organisms"},{:title=>"Cell Structure and Function"},{:title=>"Ecology and Environment"}])
topics[0].chapters.create([{:name=>"The Living World"},{:name=>"Animal Kingdom"},{:name=>"Plant Kingdom"}])
topics[1].chapters.create([{:name=>"Cell Division"},{:name=>"Enzyme"},{:name=>"Biomolecules"}])
topics[2].chapters.create([{:name=>"Ecosystem"},{:name=>"Human Population"},{:name=>"Environmental Issues"}])

chapter = Chapter.first
question = chapter.questions.create(:q_type=>'easy',:description=>"Identify from the following, the only taxonomic category that has a real existence")
question.choices.create([{:param=>"Phylum"},{:param=>"Species"},{:param=>"Genus"},{:param=>"Kingdom"}])
question = chapter.questions.create(:q_type=>'easy',:description=>"In five kingdom system, the main basis of classification is")
question.choices.create([{:param=>"Structure of cell wall"},{:param=>"Nutrition"},{:param=>"Structure of nucleus"},{:param=>"Asexual reproduction"}])
question = chapter.questions.create(:q_type=>'medium',:description=>"In which kingdom would you classify the archaea and nitrogen-fixing organism, if the five-kingdom system of classification is used")
question.choices.create([{:param=>"Protista"},{:param=>"Fungi"},{:param=>"Plantae"},{:param=>"Monera"}])
chapter = Chapter.last
question = chapter.questions.create(:q_type=>'medium',:description=>"The Phylogenetic system of classification was put forth by")
question.choices.create([{:param=>"Theophrastus"},{:param=>"George Bentham and Joseph Dalton Hooker"},{:param=>"Carolus Linnaeus"},{:param=>"Adolf Engler and Karl Prantl"}])
question = chapter.questions.create(:q_type=>'medium',:description=>"Which series ends with the cohort umbellales in Bentham and Hooker's system of classification?")
question.choices.create([{:param=>"Heteromerae"},{:param=>"Disciflorae"},{:param=>"Thalamiflorae"},{:param=>"Calyciflorae"}])
question = chapter.questions.create(:q_type=>'hard',:description=>"Which one of the taxonomic aids can give comprehensive account of complete compiled information of any one genus or family at a particular time?")
question.choices.create([{:param=>"Taxonomic key"},{:param=>"Flora"},{:param=>"Herbarium"},{:param=>"Monograph"}])

Question.all.each{|question|
    question.correct_choice = question.choices[rand(0..3)]
    question.save
}
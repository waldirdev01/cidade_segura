import '../models/person.dart';
const String kHOME = '/';
const String kPERSONPERFILPAGE = '/person-perfil-page';
const String kPERSONCADFORM = '/person-cad-form';

List<Person> kItems = [
  Person(
      id: '1',
      name: 'Fulano da Silva',
      apelido: 'vulgo',
      motherName: 'Mãe',
      address: 'rua',
      anotation: '''
      Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
      Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
      when an unknown printer took a galley of type and scrambled it to make a type
       specimen book. It has survived not only five centuries, but also the leap into 
       electronic typesetting, remaining essentially unchanged. It was popularised in 
       the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
       and more recently with desktop publishing software like Aldus PageMaker 
       including versions of Lorem Ipsum
      ''',
      cellphone: '9658452',
      imageUrl:
          'http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png'),
  Person(
      id: '2',
      name: 'Beltrano',
      apelido: 'vulgo',
      motherName: 'Mãe',
      address: 'rua',
      anotation: 'crimes',
      cellphone: '9658452',
      imageUrl:
          "http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png"),
  Person(
      id: '3',
      name: 'Ciclano',
      apelido: 'vulgo',
      motherName: 'Mãe',
      address: 'rua',
      anotation: 'crimes',
      cellphone: '9658452',
      imageUrl:
          "http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png"),
  Person(
      id: '4',
      name: 'Fulano',
      motherName: 'Mãe',
      address: 'rua',
      anotation: 'crimes',
      cellphone: '9658452',
      imageUrl:
          "http://cbissn.ibict.br/images/phocagallery/galeria2/thumbs/phoca_thumb_l_image03_grd.png",
      apelido: 'Vulgo'),
];

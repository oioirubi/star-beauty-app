import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final Profile profile;

  ProfileCard({super.key, required this.profile});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool isMatch = true;

  bool showContact = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          setState(
            () {
              showContact = isMatch ? !showContact : false;
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isMatch && showContact
                  ? _buildContatDetails(onDeletePressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Você deletou ${widget.profile.name}'),
                        ),
                      );
                    })
                  : _buildBasicDetails(
                      onFavoritePressed: () => {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Você gostou de ${widget.profile.name}'),
                          ),
                        )
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  _buildBasicDetails({Function? onFavoritePressed}) {
    // Foto de Perfil
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
              widget.profile.image), // Usando NetworkImage para imagens da web
        ),
        SizedBox(height: 8),
        Text(
          widget.profile.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(widget.profile.category),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.profile.type),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                onFavoritePressed?.call();
              },
            ),
          ],
        ),
      ],
    );
  }

  _buildContatDetails({Function? onDeletePressed}) {
    // Foto de Perfil
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
              widget.profile.image), // Usando NetworkImage para imagens da web
        ),
        SizedBox(height: 8),
        Text(
          widget.profile.email,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(widget.profile.phoneNumber),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.profile.type),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onDeletePressed?.call();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class Profile {
  final String name;
  final String category;
  final String type;
  final String image;
  final String phoneNumber;
  final String email;

  Profile({
    required this.phoneNumber,
    required this.email,
    required this.name,
    required this.category,
    required this.type,
    required this.image,
  });
}

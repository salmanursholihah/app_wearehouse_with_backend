import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../user/bloc/update_profil/profile_update_bloc.dart';
import '../../user/bloc/update_profil/profile_update_event.dart';
import '../../user/bloc/update_profil/profile_update_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const primaryColor = Color(0xFF2FA4A9);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  File? selectedImage;

  bool _isInit = false; // ⬅️ FLAG PENTING

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: EditProfilePage.primaryColor,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded && !_isInit) {
            nameController.text = state.profile.name;
            _isInit = true; // ⬅️ SET SEKALI SAJA
          }

          if (state is ProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.pop(context);
          }

          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _avatarSection(
                state is ProfileLoaded ? state.profile.image : null,
              ),
              const SizedBox(height: 24),
              _inputField(
                label: 'Full Name',
                controller: nameController,
              ),
              const SizedBox(height: 32),
              _saveButton(context),
            ],
          );
        },
      ),
    );
  }

  // =========================
  // AVATAR
  // =========================
  Widget _avatarSection(String? imageUrl) {
    return Center(
      child: Stack(
        children: [
          // CircleAvatar(
          //   radius: 48,
          //   backgroundColor: Colors.white,
          //   backgroundImage: selectedImage != null
          //       ? FileImage(selectedImage!)
          //       : imageUrl != null
          //           ? NetworkImage(imageUrl) as ImageProvider
          //           : null,
          //   child: selectedImage == null && imageUrl == null
          //       ? const Icon(
          //           Icons.person,
          //           size: 50,
          //           color: EditProfilePage.primaryColor,
          //         )
          //       : null,
          // ),

          CircleAvatar(
  radius: 48,
  backgroundImage: imageUrl != null
      ? NetworkImage(imageUrl)
      : null,
  child: imageUrl == null
      ? const Icon(Icons.person)
      : null,
),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: EditProfilePage.primaryColor,
                child: Icon(Icons.edit, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // INPUT
  // =========================
  Widget _inputField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // =========================
  // SAVE BUTTON
  // =========================
  Widget _saveButton(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: EditProfilePage.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          context.read<ProfileBloc>().add(
                UpdateProfile(
                  name: nameController.text,
                  image: selectedImage,
                ),
              );
        },
        child: const Text(
          'Save Changes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // =========================
  // IMAGE PICKER
  // =========================
 Future<void> _pickImage() async {
  final picker = ImagePicker();
  final result = await picker.pickImage(source: ImageSource.gallery);

  if (result == null) return;

  final directory = await getApplicationDocumentsDirectory();
  final newPath =
      '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

  final newImage = await File(result.path).copy(newPath);

  setState(() {
    selectedImage = newImage;
  });
}
}

class ProfileSuccess {
}



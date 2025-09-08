import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:participa/domain/entities/description_entity/description_entity.dart';
import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/presentation/widgets/cards_information/cards_information.dart';
import 'package:participa/presentation/widgets/custom_button/custom_button.dart';
import 'package:participa/presentation/widgets/textfield/textfield.dart';

class AddPautaPage extends StatefulWidget {
  const AddPautaPage({super.key});

  @override
  State<AddPautaPage> createState() => _AddPautaPageState();
}

class _AddPautaPageState extends State<AddPautaPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final List<DescriptionEntity> _descriptions = [];

  final _sectionTitleController = TextEditingController();
  final _sectionInfoController = TextEditingController();

  File? _pickedImageFile;
  Uint8List? _pickedImageBytes;
  String? _pickedImageMime;

  bool _showTitleError = false;
  bool _showImageError = false;
  bool _showDescError = false;

  @override
  void dispose() {
    _titleController.dispose();
    _sectionTitleController.dispose();
    _sectionInfoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked == null) return;

      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        if (!mounted) return;
        setState(() {
          _pickedImageBytes = bytes;
          _pickedImageFile = null;
          _pickedImageMime = picked.mimeType ?? 'image/png';
          _showImageError = false;
        });
      } else {
        if (!mounted) return;
        setState(() {
          _pickedImageFile = File(picked.path);
          _pickedImageBytes = null;
          _pickedImageMime = null;
          _showImageError = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() {});
    }
  }

  void _showAddSectionDialog() {
    _sectionTitleController.clear();
    _sectionInfoController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Adicionar Seção',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Textfield(
                    controller: _sectionTitleController,
                    hintText: 'Título da seção',
                    obscureText: false,
                    inputType: TextInputType.text,
                    icon: Icons.title,
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informações da seção',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(143, 14, 124, 87),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _sectionInfoController,
                            maxLines: 5,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                              hintText:
                                  'Descreva as informações desta seção...',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_sectionTitleController.text.trim().isEmpty ||
                                  _sectionInfoController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Preencha todos os campos',
                                    ),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.error,
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );
                                return;
                              }

                              final newSection = DescriptionEntity(
                                title: _sectionTitleController.text.trim(),
                                info: _sectionInfoController.text.trim(),
                              );

                              setState(() {
                                _descriptions.add(newSection);
                                _showDescError = false;
                              });

                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),
                            child: Text(
                              'Adicionar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _removeDescription(int index) {
    if (index < 0 || index >= _descriptions.length) return;

    final removed = _descriptions[index];

    final messenger = ScaffoldMessenger.of(context);

    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Remover seção',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Deseja remover a seção "${removed.title}"?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(
              'Cancelar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Remover',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed != true || !mounted) return;

      setState(() => _descriptions.removeAt(index));
    });
  }

  PautaEntity _buildPautaPreview() {
    final imageString = kIsWeb && _pickedImageBytes != null
        ? 'data:${_pickedImageMime ?? 'image/png'};base64,${base64Encode(_pickedImageBytes!)}'
        : (_pickedImageFile?.path ?? '');

    return PautaEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text.trim(),
      image: imageString,
      userId: '1',
      userName: 'Pedro Rodrigues',
      userPhotoUrl: 'https://i.pravatar.cc/150?img=3',
      createdAt: DateTime.now(),
      descriptions: List.unmodifiable(_descriptions),
      comments: const [],
    );
  }

  Widget _imagePreview() {
    if (_pickedImageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: 200,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          child: Image.memory(
            _pickedImageBytes!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                const Center(child: Icon(Icons.broken_image, size: 42)),
          ),
        ),
      );
    }

    if (_pickedImageFile == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: 200,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                size: 42,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              const SizedBox(height: 6),
              Text(
                'Toque para selecionar uma imagem',
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        _pickedImageFile!,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const Center(child: Icon(Icons.broken_image, size: 42)),
      ),
    );
  }

  void _validateAndProceed() {
    final missing = <String>[];

    final titleEmpty = _titleController.text.trim().isEmpty;
    final imageMissing = _pickedImageFile == null && _pickedImageBytes == null;
    final descMissing = _descriptions.isEmpty;

    if (titleEmpty) missing.add('Título');
    if (imageMissing) missing.add('Imagem');
    if (descMissing) missing.add('Descrição (pelo menos 1)');

    setState(() {
      _showTitleError = titleEmpty;
      _showImageError = imageMissing;
      _showDescError = descMissing;
    });

    if (missing.isNotEmpty) {
      _showMissingDialog(missing);
      return;
    }

    final pauta = _buildPautaPreview();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PautaDetailExPage(pauta: pauta, showAppBar: false),
      ),
    );
  }

  void _showMissingDialog(List<String> missing) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Campos obrigatórios',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Os seguintes campos precisam ser preenchidos:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: missing
                    .map(
                      (m) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                m,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Entendi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Nova Pauta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textfield(
                      controller: _titleController,
                      hintText: 'Título da pauta',
                      obscureText: false,
                      inputType: TextInputType.text,
                      icon: Icons.title,
                    ),
                    if (_showTitleError)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, left: 20.0),
                        child: Text(
                          'Informe o título da pauta',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 18),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(onTap: _pickImage, child: _imagePreview()),
                    if (_showImageError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                        child: Text(
                          'Adicione uma imagem para a pauta',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seções de Informação',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: FloatingActionButton(
                        onPressed: _showAddSectionDialog,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(Icons.add, size: 28),
                      ),
                    ),
                  ],
                ),

                if (_showDescError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 12.0),
                    child: Text(
                      'Adicione pelo menos uma seção',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                if (_descriptions.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Nenhuma seção adicionada',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Clique no botão + para adicionar uma nova seção',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _descriptions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final section = _descriptions[index];
                        return SizedBox(
                          width: 200,
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          section.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                        onPressed: () =>
                                            _removeDescription(index),
                                        tooltip: 'Remover seção',
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: Text(
                                      section.info,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.tertiary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 18),
        child: SizedBox(
          height: 56,
          child: CustomButton(
            text: 'Continuar',
            onPressed: _validateAndProceed,
          ),
        ),
      ),
    );
  }
}

class PautaDetailExPage extends StatelessWidget {
  final PautaEntity pauta;
  final bool showAppBar;

  const PautaDetailExPage({
    super.key,
    required this.pauta,
    this.showAppBar = true,
  });

  Widget _buildTopImage(BuildContext context) {
    final imagePath = pauta.image;

    if (imagePath.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: 360,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          child: const Center(child: Icon(Icons.image, size: 64)),
        ),
      );
    }

    if (imagePath.startsWith('data:image/')) {
      try {
        final comma = imagePath.indexOf(',');
        final b64 = imagePath.substring(comma + 1);
        final bytes = base64Decode(b64);
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Image.memory(
            bytes,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 360,
            errorBuilder: (ctx, err, st) => Container(
              height: 360,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              child: const Center(child: Icon(Icons.broken_image)),
            ),
          ),
        );
      } catch (e) {}
    }

    final isUrl =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');
    if (isUrl) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 360,
          errorBuilder: (ctx, err, st) => Container(
            height: 360,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            child: const Center(child: Icon(Icons.broken_image)),
          ),
        ),
      );
    }

    try {
      final file = File(imagePath);
      if (!file.existsSync()) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            height: 360,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            child: const Center(child: Icon(Icons.broken_image)),
          ),
        );
      }

      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Image.file(
          file,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 360,
          errorBuilder: (ctx, err, st) => Container(
            height: 360,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            child: const Center(child: Icon(Icons.broken_image)),
          ),
        ),
      );
    } catch (e) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: 360,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          child: const Center(child: Icon(Icons.broken_image)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                _buildTopImage(context),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 20,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(pauta.userPhotoUrl),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pauta.userName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${pauta.createdAt.day}/${pauta.createdAt.month}/${pauta.createdAt.year} ${pauta.createdAt.hour.toString().padLeft(2, '0')}:${pauta.createdAt.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Sobre a pauta',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: pauta.descriptions.isNotEmpty
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: pauta.descriptions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final desc = pauta.descriptions[index];
                        return CardsInformation(
                          title: desc.title,
                          description: desc.info,
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Nenhuma descrição adicionada',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text('Voltar'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Confirmar postagem'),
                            content: const Text(
                              'Deseja realmente postar esta pauta?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: const Text('Confirmar'),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text('Pauta postada com sucesso'),
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text('Postar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

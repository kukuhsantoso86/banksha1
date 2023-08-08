import 'package:bank_sha1/blocs/auth/auth_bloc.dart';
import 'package:bank_sha1/shared/shared_methods.dart';
import 'package:bank_sha1/shared/theme.dart';
import 'package:bank_sha1/ui/widgets/buttons.dart';
import 'package:bank_sha1/ui/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'my profile',
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/sign-in',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthSuccess) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 22,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: state.user.profilePicture == null
                                ? const AssetImage(
                                    'assets/img_profile.png',
                                  )
                                : NetworkImage(state.user.profilePicture!)
                                    as ImageProvider,
                          ),
                        ),
                        child: state.user.verified == 1
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: whiteColor,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check_circle,
                                      color: greenColor,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.user.name.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_edit_profile.png',
                        title: 'edit profile',
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/profile-edit');
                          }
                        },
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_pin.png',
                        title: 'my pin',
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/profile-edit-pin');
                          }
                        },
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_wallet.png',
                        title: 'wallet settings',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_reward.png',
                        title: 'my rewards',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_help.png',
                        title: 'help center',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_logout.png',
                        title: 'log out',
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 87,
                ),
                CustomTextButton(
                  title: 'report a problem',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}

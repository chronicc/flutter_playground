import 'package:flutter/material.dart';
import 'package:oauth/components/image_tile.dart';
import 'package:oauth/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50.0),
              Icon(
                Icons.person_pin,
                color: Theme.of(context).colorScheme.primary,
                size: 128,
              ),
              const SizedBox(height: 50.0),
              const Text(
                'Tap a provider to sign in',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 25.0),
              const Divider(),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageTile('images/google.png', onTap: () async {
                    if (await authService.signInWithGoogle()) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logged in with Google'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    }
                  }),
                  const SizedBox(width: 10.0),
                  ImageTile('images/apple.png', onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Apple Login used'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }),
                  const SizedBox(width: 10.0),
                  ImageTile('images/x.png', onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('X Login used'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }),
                  const SizedBox(width: 10.0),
                  ImageTile('images/facebook.png', onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Facebook Login used'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              const SizedBox(height: 25.0),
              Row(children: <Widget>[
                Text(
                    'Account: ${authService.account == null ? 'Not logged in' : 'Logged in'}')
              ]),
              Row(children: <Widget>[
                Text('Display Name: ${authService.account?.displayName}')
              ]),
              Row(children: <Widget>[Text('Email: ${authService.account?.email}')]),
              const SizedBox(height: 25.0),
              FilledButton(
                onPressed: authService.authenticated
                    ? () async {
                        if (await authService.signOut()) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Logged out'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        }
                      }
                    : null,
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

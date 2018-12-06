From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu,  6 Dec 2018 16:00:22 +0900
Subject: [cip-dev] Updates to CIP Core reference images
Message-ID: <1544079623-24800-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

To CIP core users:

I have added more functionality to the standard CIP core reference images and their SDK. Please, check the details in the patch.

[PATCH] common: improve initialization and add more packages

For CIP testers, one important change is that now the prompt is "cip-project" instead of "cip". I hope that makes it easier for LAVA to recognize the prompt during boot.

The SDK is known to cause exception faults on Ubuntu 16.04 (it looks like a problem with libc), but it should work on Debian Jessie and Debian Buster.

I have added a preliminar list of default packages, but we still need to discuss what packages do we want to support in the Tiny profile.

Best regards,
Daniel

From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed,  5 Jun 2019 11:16:44 +0900
Subject: [cip-dev] porting iwg20m to isar-cip-core
Message-ID: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

I tried to add a recipe for iwg20m's u-boot. That board
only supports version 2013.01 and does not support distro boot.

There were a couple of build errors, one of them I couldn't
easily solve (unrecognized option '-Wl,-z,relro'). 
But for now, I wanted to confirm if the structure of the recipe is OK.

I wanted to use uImage because that's what is used in the
iwg20m manual, and it's known to work on Deby as well. 
Ref: https://gitlab.com/cip-project/cip-core/deby/blob/master/poky/meta-cip-iwg20m/README.IWG20M.txt
Do you suggest that we should use bootz instead of bootm?
Is uImage not recommended or something? I have used uImage in many boards.

As for the kernel image location, since we do not have u-boot
distro support I will move it manually from the root partition
to the boot partition using a postinstall script inside the
customizations recipe. If there is a better option please 
let me know.

[isar-cip-core] iwg20m: temporary patch for review v2

Thanks,
Daniel

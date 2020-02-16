From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 16 Feb 2020 09:35:21 +0100
Subject: [cip-dev] 4.19.103, 4.19.104: significant KVM changes
Message-ID: <20200216083521.GA19392@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

KVM received pretty significant changes in 4.19.103/4.19.104. We do
have KVM enabled in some of the configs, but I'm not sure if it is
actually in use.

If so, 4.19.104 might be worth testing.

(I assume we don't run KVM in our gitlab tests... do we?)

Best regards,
									Pavel

4.19.y-cip/arm64/renesas_defconfig:CONFIG_KVM=y
4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_KVM=m
4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_KVM_INTEL=m
4.19.y-cip/x86/siemens_ipc227e_defconfig:CONFIG_KVM=m
4.19.y-cip/x86/siemens_ipc227e_defconfig:CONFIG_KVM_INTEL=m
4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_KVM=m
4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_KVM_INTEL=m
4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_KVM_AMD=m
4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_KVM=m
4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_KVM_INTEL=m
4.4.y-cip/x86/plathome_obsvx1.config:# CONFIG_KVM_AMD is not set
4.4.y-cip/x86/siemens_iot2000.config:CONFIG_KVM=m
4.4.y-cip/x86/siemens_iot2000.config:CONFIG_KVM_INTEL=m
4.4.y-cip/x86/siemens_iot2000.config:CONFIG_KVM_AMD=m

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200216/d82d01de/attachment.sig>

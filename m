From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:42 +0200
Subject: [cip-dev] [PATCH 00/14] EFI capsule update support for IOT2000
	devices
Message-ID: <cover.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Last chunk: This backports EFI capsule updates, primarily for the use
with the IOT2020 and IOT2040, the latter with Quark-proprietary security
header format. The feature should also work for the Galileo Gen 2 and,
at least conceptually, for any EFI capsule update compatible firmware.

Jan

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: joeyli <jlee@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kweh Hock Leong <hock.leong.kweh@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-efi at vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: <stable@vger.kernel.org> # v4.7
Cc: Thomas Gleixner <tglx@linutronix.de>

Ard Biesheuvel (3):
  efi/capsule-loader: Use a cached copy of the capsule header
  efi/capsule-loader: Redirect calls to efi_capsule_setup_info() via
    weak alias
  efi/capsule-loader: Use page addresses rather than struct page
    pointers

Austin Christ (1):
  efi/capsule: Allocate whole capsule into virtual memory

Jan Kiszka (5):
  efi/capsule: Fix return code on failing kmap/vmap
  efi/capsule: Remove pr_debug() on ENOMEM or EFAULT
  efi/capsule: Clean up pr_err/_info() messages
  efi/capsule: Adjust return type of efi_capsule_setup_info()
  efi/capsule: Add support for Quark security header

Kweh, Hock Leong (1):
  efi: Add misc char driver interface to update EFI firmware

Matt Fleming (4):
  efi: Move efi_status_to_err() to drivers/firmware/efi/
  efi: Add 'capsule' update support
  x86/efi: Force EFI reboot to process pending capsules
  efi/capsule: Move 'capsule' to the stack in efi_capsule_supported()

 arch/x86/kernel/reboot.c              |   9 +
 arch/x86/platform/efi/quirks.c        | 137 ++++++++++++++
 drivers/firmware/efi/Kconfig          |  19 ++
 drivers/firmware/efi/Makefile         |   2 +
 drivers/firmware/efi/capsule-loader.c | 330 ++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/capsule.c        | 294 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c            |  33 ++++
 drivers/firmware/efi/reboot.c         |  12 +-
 drivers/firmware/efi/vars.c           |  33 ----
 include/linux/efi.h                   |  34 ++++
 10 files changed, 869 insertions(+), 34 deletions(-)
 create mode 100644 drivers/firmware/efi/capsule-loader.c
 create mode 100644 drivers/firmware/efi/capsule.c

-- 
2.12.3

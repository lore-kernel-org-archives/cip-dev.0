From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Wed, 20 Feb 2019 06:25:44 +0000
Subject: [cip-dev] swupdate supporting binary delta caused an error
Message-ID: <OSAPR01MB2723989E295BC468A990FA56D97D0@OSAPR01MB2723.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Christian,

I'm Akihiro Suzuki of Toshiba.
I was introduced you by Daniel.

I'm trying to use latest swupdate to use binary delta.
I used 2 different size of files (10MiB and 50MiB) as update target,
but their update results were different: 10MiB was success but 50MiB caused an error.

I suppose that the cause of the error is buffer related bug or perhaps my wrong test environment.
Could you check following (or attached) details and give me some advice?

Best regards,
Suzuki

---

swupdate simple test details
============================

Environment
-----------

    $ lsb_release -a
    No LSB modules are available.
    Distributor ID: Ubuntu
    Description:    Ubuntu 18.04.2 LTS
    Release:        18.04
    Codename:       bionic

    $ uname -a
    Linux garnet 4.15.0-45-generic #48-Ubuntu SMP Tue Jan 29 16:28:13 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

Make test target files
----------------------

    $ mkdir -p /path/to/test/10M
    $ cd /path/to/test/10M
    $ dd if=/dev/zero of=10M.img bs=10M count=1 oflag=sync

    $ mkdir -p /path/to/test/50M
    $ cd /path/to/test/50M
    $ dd if=/dev/zero of=50M.img bs=50M count=1 oflag=sync

Make binary deltas
------------------

    $ cd /path/to/test/10M
    $ rdiff signature 10M.img 10M.sig
    $ rdiff delta 10M.sig 10M.img 10M.delta

    $ cd /path/to/test/50M
    $ rdiff signature 50M.img 50M.sig
    $ rdiff delta 50M.sig 50M.img 50M.delta

Make swu (cpio) files
---------------------

    $ cd /path/to/test/10M
    $ cat sw-description
    software =
    {
            version = "0.1.0";
            files: (
                    {
                            type = "rdiff_file";
                            filename = "10M.delta";
                            path = "/path/to/test/10M/10M.img";
                    }
            );
    }
    $ for i in sw-description 10M.delta; do echo $i; done | cpio -ov -H crc > my-software_1.0.swu
    sw-description
    10M.delta
    42 blocks

    $ cd /path/to/test/50M
    $ cat sw-description
    software =
    {
            version = "0.1.0";
            files: (
                    {
                            type = "rdiff_file";
                            filename = "50M.delta";
                            path = "/path/to/test/50M/50M.img";
                    }
            );
    }
    $ for i in sw-description 50M.delta; do echo $i; done | cpio -ov -H crc > my-software_1.0.swu
    sw-description
    50M.delta
    202 blocks

Make swupdate
-------------

    $ mkdir /path/to/swupdate
    $ cd /path/to/swupdate
    $ git clone https://github.com/sbabic/swupdate.git
    $ cd swupdate
    $ git log -1 --oneline
    cd5dcf5 (HEAD -> master, origin/master, origin/HEAD) Same version must be discarded by no-downgrading
    $ make distclean
    $ make with_rdiff_defconfig
    $ make menuconfig
    [Disable "Enable verification of signed images" (CONFIG_SIGNED_IMAGES)]
    [Disable "Swupdate Settings ---> General Configuration ---> check for hardware / software compatibility" (CONFIG_HW_COMPATIBILITY)]
    $ make

Execute swupdate for 10MiB target
---------------------------------

    $ ./swupdate -v -i /path/to/test/10M/my-software_1.0.swu
    Swupdate v2018.11.0

    Licensed under GPLv2. See source distribution for detailed copyright notices.

    [INFO ] : SWUPDATE running :  [lua_handlers_init] : No Lua handler(s) found.
    [TRACE] : SWUPDATE running :  [lua_handlers_init] : Lua handler search path:
    ------------------------------ (snip) ------------------------------
    [TRACE] : SWUPDATE running :  [rdiff_log] : swupdate: (rs_job_complete) patch job complete
    [TRACE] : SWUPDATE running :  [apply_rdiff_chunk_cb] : rdiff processing done.
    Software updated successfully
    Please reboot the device to start the new software
    [INFO ] : SWUPDATE successful !

    ===> 10MiB target was success

Execute swupdate for 50MiB target
---------------------------------

    $ ./swupdate -v -i /path/to/test/50M/my-software_1.0.swu
    Swupdate v2018.11.0

    Licensed under GPLv2. See source distribution for detailed copyright notices.

    [INFO ] : SWUPDATE running :  [lua_handlers_init] : No Lua handler(s) found.
    [TRACE] : SWUPDATE running :  [lua_handlers_init] : Lua handler search path:
    ------------------------------ (snip) ------------------------------
    [TRACE] : SWUPDATE running :  [rdiff_log] : swupdate: (rs_patch_s_copy) COPY(where=0, len=2048)
    [TRACE] : SWUPDATE running :  [apply_rdiff_chunk_cb] : rdiff chunk processing blocked for input, getting more chunk data.
    [ERROR] : SWUPDATE failed [0] ERROR handlers/rdiff_handler.c : fill_inbuffer : 114 : Assertion violated: target - buffers->next_in <= RDIFF_BUFFER_SIZE.
    double free or corruption (!prev)
    Aborted (core dumped)

    ===> 50MiB target caused an error

---
Akihiro Suzuki
Corporate Software Engineering & Technology Center
Toshiba Corporation
Tel: +81-44-549-2476
E-mail: akihiro27.suzuki at toshiba.co.jp 

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: swupdate_simple_test_details.txt
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190220/936e877e/attachment.txt>

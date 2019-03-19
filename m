From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 19 Mar 2019 10:09:54 +0100
Subject: [cip-dev] debootrap error
In-Reply-To: <08760c2cbcce3290a6c0c843855b6e8decc668bf.camel@siemens.com>
References: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
	<TY2PR01MB5146389CBF352FDC6F104262D9440@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<cc3ea2e6-79d9-ed10-f1a3-cf615c3e6ec8@siemens.com>
	<TY2PR01MB514615FB285AF43385A49493D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<02844bd9-fe8d-199f-27e3-42f59bb64163@siemens.com>
	<41b9fdc25373948d08ad360dc1db13340648cc93.camel@siemens.com>
	<1d4da986-92e6-87e3-11a4-30e15b48359d@siemens.com>
	<TY2PR01MB51463965A654EA6074848D00D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<24beb970-86d2-c672-08e7-12732f9dd467@siemens.com>
	<204e9223-ed2b-9697-38a9-847fe2ee8704@siemens.com>
	<TY2PR01MB5146C28D70580735866F91FDD9400@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<48868c49-3ab2-57f3-2a1e-2a7cf4ff839c@siemens.com>
	<975512b8-1cf8-a830-29cb-3cd59462135a@siemens.com>
	<08760c2cbcce3290a6c0c843855b6e8decc668bf.camel@siemens.com>
Message-ID: <aba4516c-5aa1-01ca-3874-ed2db3f5ff32@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 19.03.19 09:01, Claudius Heine wrote:
> On Tue, 2019-03-19 at 08:51 +0100, Jan Kiszka wrote:
>> On 19.03.19 08:22, Claudius Heine wrote:
>>> Hi Suzuki-san,
>>>
>>> On 19/03/2019 06.18, akihiro27.suzuki at toshiba.co.jp wrote:
>>>> Hi,
>>>>
>>>>>> That is how my qemu-arm setting looks like. Do you have a
>>>>>> differentqemu path?
>>>>>>
>>>>>> $ cat /proc/sys/fs/binfmt_misc/qemu-arm
>>>>>> enabled
>>>>>> interpreter /usr/bin/qemu-arm-static
>>>>>> flags: OCF
>>>>>> offset 0
>>>>>> magic 7f454c4601010100000000000000000002002800
>>>>>> mask ffffffffffffff00fffffffffffffffffeffffff
>>>> My qemu-arm setting is as follows:
>>>>
>>>>       $ cat /proc/sys/fs/binfmt_misc/qemu-arm
>>>>       enabled
>>>>       interpreter /usr/bin/qemu-arm
>>>>       flags: OC
>>>>       offset 0
>>>>       magic 7f454c4601010100000000000000000002002800
>>>>       mask ffffffffffffff00fffffffffffffffffeffffff
>>>>
>>>> According to this, the interpreter path was not same.
>>>> My machine used /usr/bin/qemu-arm but Claudius's machine used
>>>> /usr/bin/qemu-arm-static.
>>>>
>>>> If the first place, my machine didn't have /usr/bin/qemu-arm-
>>>> static.
>>>> So, I installed qemu-user-static as follows:
>>>>
>>>>       $ sudo aptitude install qemu-user-static
>>>>       [sudo] password for akihiro:
>>>>       The following NEW packages will be installed:
>>>>         qemu-user-static{b}
>>>>       0 packages upgraded, 1 newly installed, 0 to remove and 0
>>>> not upgraded.
>>>>       Need to get 10.0 MB of archives. After unpacking 101 MB will
>>>> be used.
>>>>       The following packages have unmet dependencies:
>>>>        qemu-user-static : Conflicts: qemu-user-binfmt but
>>>> 1:2.11+dfsg-1ubuntu7.10 is installed
>>>>        qemu-user-binfmt : Conflicts: qemu-user-static but
>>>> 1:2.11+dfsg-1ubuntu7.10 is to be installed
>>>>       The following actions will resolve these dependencies:
>>>>            Remove the following packages:
>>>>       1)     qemu-user-binfmt [1:2.11+dfsg-1ubuntu7.10 (bionic-
>>>> updates, now)]
>>>>       Accept this solution? [Y/n/q/?] Y
>>>>       The following NEW packages will be installed:
>>>>         qemu-user-static
>>>>       The following packages will be REMOVED:
>>>>         qemu-user-binfmt{a}
>>>>       0 packages upgraded, 1 newly installed, 1 to remove and 0
>>>> not upgraded.
>>>>       Need to get 10.0 MB of archives. After unpacking 101 MB will
>>>> be used.
>>>>       Do you want to continue? [Y/n/?] Y
>>>>       Get: 1 http://ftp.jaist.ac.jp/pub/Linux/ubuntu bionic-
>>>> updates/universe
>>>> amd64 qemu-user-static amd64 1:2.11+dfsg-1ubuntu7.10 [10.0 MB]
>>>>       Fetched 10.0 MB in 1min 5s (155 kB/s)
>>>>       (Reading database ... 299683 files and directories currently
>>>> installed.)
>>>>       Removing qemu-user-binfmt (1:2.11+dfsg-1ubuntu7.10) ...
>>>>       Selecting previously unselected package qemu-user-static.
>>>>       (Reading database ... 299683 files and directories currently
>>>> installed.)
>>>>       Preparing to unpack
>>>> .../qemu-user-static_1%3a2.11+dfsg-1ubuntu7.10_amd64.deb ...
>>>>       Unpacking qemu-user-static (1:2.11+dfsg-1ubuntu7.10) ...
>>>>       Setting up qemu-user-static (1:2.11+dfsg-1ubuntu7.10) ...
>>>>       Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
>>>>
>>>> After that, I checked my qemu-arm setting.
>>>> The interpreter path has been changed to /usr/bin/qemu-arm-static
>>>> as below:
>>>>
>>>>       $ cat /proc/sys/fs/binfmt_misc/qemu-arm
>>>>       enabled
>>>>       interpreter /usr/bin/qemu-arm-static
>>>>       flags: OC
>>>>       offset 0
>>>>       magic 7f454c4601010100000000000000000002002800
>>>>       mask ffffffffffffff00fffffffffffffffffeffffff
>>>>
>>>> After that, I built board-bbb.yml as below, and it succeeded!
>>>>
>>>>       $ ./kas-docker --isar build kas.yml:board-bbb.yml
>>>>
>>>> The root cause of this error is that my machine was not using
>>>> statically linked user mode qemu binaries?
>>>
>>> Well the docker container has the 'qemu-user-static' files
>>> installed as a
>>> dependency of qemu-debootstrap. The dynamic linking version would
>>> not work here,
>>> because qemu-deboostrap will copy just the one binary to the
>>> bootstrapped rootfs
>>> before chrooting into it. The binfmt_misc settings needs to point
>>> to the qemu
>>> static binary that was copied to the rootfs for this to work. The
>>> error of
>>> course is pretty misleading and stumbled over that very often
>>> myself.
>>>
>>> And what your problem shows as well is that the call of 'update-
>>> binfmts
>>> --enable' (which happens in the docker entry point script) does not
>>> seem to fix
>>> the path.
>>
>> ...which is good to know. Maybe it gets tricked by something being
>> enabled
>> already. But I thought I tested this. Anyway, I guess we need to
>> study that
>> script /wrt how to achieve some reliable rewriting of the settings.
> 
> Well you could just call '/var/lib/dpkg/info/qemu-user-static.postinst'
> from the docker entry point :)
> 

Ugly... And that call will actually be nop due to how the script works (if it 
works at all).

It seems this binfmt installation never worked for the isar-kas
container:

builder at 384a365634ab:~$ ls /usr/share/binfmts/
python2.7  python3.5

And python2.7 does a file installation+ an update-binfmt --import - rather than 
a --install - during its postinst.

"For packages, this is preferable to using the --install option, as
a format file can be installed without update-binfmts needing to be
available."
[update-binfmt man page]

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

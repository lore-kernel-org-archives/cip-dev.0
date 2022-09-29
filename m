Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03062C433FE
	for <webhook@archiver.kernel.org>; Thu, 29 Sep 2022 15:43:07 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.66])
 by mx.groups.io with SMTP id smtpd.web10.11826.1664466184399429513
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Sep 2022 08:43:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=foqPky/Y;
 spf=pass (domain: siemens.com, ip: 40.107.1.66,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEm78y56AauvKf8uWk/l5nM4MJrF6f/zt71a+sA86sFnxvt51LvljEv+B6c9+mmZ0Er0yh6q5XwBAWt/p5Ahl7wHPj0sZc8ztpaOUmwWctBcWx9VaF0bxqkR72DHVHrcVy4M6QhpRBBO6DkS2X4mKhNg13PtVu+AorBfbjnVP6YtqBjHYK+BQHKQIEZyoKo2agrON/squoyuNx3FBkg6CzcI98dTDVwua8MMsV58WnXbfJBAJxbYOZ47v5d6YAtvLm+r7uGzqzYSSS4+9MRfUF6cNmX2E3TBxioo3pfFPlDvC7cvuWlhR9wtyA/4H5zCS2AeS1frY1cY0zPWTB7Fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z/gDHCI+lZsh1i+isRlGShc/19QfzItYJWOY62m2EA=;
 b=fUOXcDhiyoCPGDK84zYHm1MYBNw58SPBeGFAtzmStCCwDTES7PkON84i1ZZFV2XfL29t4VFfdAGApyVEAPkyLGOFHwkfWt1U1vEzDq61EtgldsFHNNKUxwzBl/6x+a3Ek23ZvBhdgZjTTQP8hKSY+yfefqjXWGfAOZXTZV2LlPYb0RYgyccVTSKPgUnMfakcTmYGQXGogmB78jruxCiR7PLVGa8fNHrDcgs152oeCYPlKvGobUHmtv+gmoQjHrGFK1ociPQzOkaX7KVWd16p7TcphKufUFUCXYuiOEcbS537dpl1AC2gx87ACz114BRFSte2h1iMhlop1EJxBEhlpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z/gDHCI+lZsh1i+isRlGShc/19QfzItYJWOY62m2EA=;
 b=foqPky/YYMp0vrNju2NqR83GpK4stNHvF2qgAnyQ8H0VlUWA0aAPu1WhSYTVtI8+hHBIx6LEsk2J2m0NC44d43HvVljsoCu3gaXPe9PLx+Re/Bs6qaq23f+docsRMWydOqf5Tgw0hJEEgyHXn5f6WOuC6dmLLcjlfbKIkr142L7gLJsaDJCV9FKpbqV+zJDS1P44glhtj5B51XgaMQLPtuBL4fkt3aYUDmKNRsgETFy1XRSWXXk/hRbHb4MnGbK+18uwXLUwdE4RkEoi2lRIYwzvIDIbWwXETbXCakiYVHUOV6EaSaXdb/G8ovj8nBeXG0PK4kFzeVPELTiWY2cRqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB5946.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 29 Sep
 2022 15:43:00 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::57df:8ca5:c3d0:6e3]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::57df:8ca5:c3d0:6e3%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 15:43:00 +0000
Message-ID: <6c4b7833-77a3-c219-259c-072b79bd5c40@siemens.com>
Date: Thu, 29 Sep 2022 17:42:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [isar-cip-core] README.secureboot.md : Update steps for bullseye
 version
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, Sai.Sathujoda@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20220920154019.555-1-Sai.Sathujoda@toshiba-tsip.com>
 <5570a5d2-5417-1fd3-bc60-7f1067bc8cc8@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <5570a5d2-5417-1fd3-bc60-7f1067bc8cc8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: b87a3871-c964-491d-7670-08daa23149f1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HmgeeGAKJWgjD9zGKkBIc1kSyEN1BcBhzgRPPuRTc2Gl1FqpLVs/kaaeOkc7fjPiJD57sW8lcSL9G567lZpha9briAeOyI/ic7B/VNiGztKvJzbNdUkO6CMRPoQTXgFfyC/HKDO0kynVEmo6ajMgZBVxdEIybcALDAtuNd+lSJlzMpztDu6pmhiv+O/cqGYyy83tI61i3qvErPKndBuhr11fNO2S3qdwpQy0+PpYFBSgY0iakCb5N3vw2OUenLEyM2P/f4hh9gqqMIvarnPQYiwzIWwLZPVyDT3SerZOgOHY9UDx2p1DOxQFsqwR2oE0mUfpTS6SnmDBE3wmorKBIU4dqhv4uio0FppRPZpWRT5u7rbcyCJdbPt+8aMzOgd78Mgx5YyDyg4mWNDVM3s0paoXTPK1jjR/LsLBViq55sMNAObZjt9wx0lrj6n5KIB7/2vFfnhdUuWuC+BgCEgZ83/Gce0pwITI/v5U9du/uzViuQg7SYAl9zagMJuBJkDJOujH61nkJmO/g3xvCINFlmYZJs9kx5S6lr4+5osBAQV8we+n2nSsS+1K2K7ighZVry0QBDx+UMzqiJvFTdMTz8HklO6u590aRsXIo4E2aMo4rTaE+8EyIsWVJVvb6+iz5atnrDmFGzNQ/T1VyhSbMIUyrS+qeKGcNYBUYYECyCrORsVg9QCNSkuFkhqD7oaTA24Jhhgwvp1P1cURSjEGs7wAyZVLSpRl5zXr+X7U+pNZxeAjTLBXSQi4of6jLgAx8kryaqyMy6Sw/ZP6QtLxMFo95mM97b6U/VVL6/94T4WFXX64oySz1u3Csf8plnst0+GGd6rmTLqFgMSgQCKNsA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(15650500001)(5660300002)(186003)(66946007)(36916002)(6666004)(53546011)(31686004)(6512007)(6506007)(8676002)(66556008)(31696002)(4326008)(8936002)(41300700001)(86362001)(82960400001)(66476007)(38100700002)(36756003)(6486002)(2616005)(19627235002)(2906002)(316002)(478600001)(83380400001)(45980500001)(43740500002)(47845001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XjCygVotdz1JtGeCFEImQ3lm+E9lp3tEPzHF9Bt8eghIQ7Rv+6v3hC4QEw3N?=
 =?us-ascii?Q?BOcy8G0tJ92+3mjqfKGO0wW1pIQoFXG5PqRj6CzPVqtjdzcxkhB4l89zHBss?=
 =?us-ascii?Q?UDhFRUmh2ZW6x6+oAalw1lZpMZ5FvaMvd0pG9jruRMB1YObsFM/pk/JNHpt1?=
 =?us-ascii?Q?xs+27ysCQXf6WvBnoU8RqfcoAA+vh5z4E69NdFVbpbx07ie1xijQ2d5NYa66?=
 =?us-ascii?Q?qocnBLo02ZoAiEa4/bqxdAMf+d5vBQcVe9q0QOul1O8uspl1Ho9U0fClqvJG?=
 =?us-ascii?Q?sL10Fi/8CvcMMxEDO8ZMQLvTZWZGHdLDfwoIzFLwCwWNQc7Cw/nInvxC/p9A?=
 =?us-ascii?Q?Fb3edjoz0ykkycbztAa+rVNHicC5ogerWHMiUOfmtRQ6vZEC0OfQD3A9OYqQ?=
 =?us-ascii?Q?gH9DY4xr2NcFvPFKnr1ZpfiJDh/pBsCRHhOhtKZGPCX95We2tWBFlR5fF5RW?=
 =?us-ascii?Q?NMA1HjCzlLecDuZnzrhb8YOWUjXTh2AP4gCjlpHTOLfxyvdS+7W+XcV2MGos?=
 =?us-ascii?Q?GqCPFHw4MKkDHTT+XqWeI4nc6gfLJI6Axqq88wuElK0dYRw2LGDf9m3xU6RM?=
 =?us-ascii?Q?BtcNzNIVKh/Rs2LuI/0FC5WoC9zhxaoOcIYLVHAguQATFawJUCPFej4ZJyYy?=
 =?us-ascii?Q?2OlZ464Nw1pxk1qEgvFwcYNiY/7Cw4YasZoF+aDagZsicdbGH5hedCyvWxL7?=
 =?us-ascii?Q?htJ0DHlHuJ5qv00V+Z9pW8l5nWHXh4B4mz2PMWrbqElr+m3HUGCARMO50uVZ?=
 =?us-ascii?Q?SZyrzeZteVb68DpWDKabir+Mhix0tgh58CbVUWy+qwAhCS4TMKz81iSRurpj?=
 =?us-ascii?Q?8wmeCJLpm8X9lxQNt0riJBsm5eXKJhFgUzUlgNsHNB+HutjvxRVlMUvMLxf8?=
 =?us-ascii?Q?+geFETnYnKuZ6AQKCwWIo3mZ27U6Jy63viVAmhkublPcdd+OZVZJmoRZs1bQ?=
 =?us-ascii?Q?lFSffl+Pql0E1u5KbVrkgrqID3bStbmovF/erzChKgCZnie40YxTLhVJkRAQ?=
 =?us-ascii?Q?8mBBsYNLeedIdZZU++/rdOzevgIHdNeQJcGeV6TDyFGoAZ3BLfvYTW+N4Tqc?=
 =?us-ascii?Q?v31OlSEJweM4XyBtcS6idEUIcmSuscqVgJ02dFVIzijSPT2VD/gBIcronY9E?=
 =?us-ascii?Q?alQFgknIdU2Cb19jUZT7dEuYia2PKwDW6hJX/qBxru0E4qoHh3q3mbGz4EkE?=
 =?us-ascii?Q?kog5WABJ5D22hyZRD2/FyY4VjbiRhrwOwcT0i4cCMOTSkG6H2tdyVRvEkbjU?=
 =?us-ascii?Q?k7FM0pBznO8a2gNZX2973h874RI8NX/tTEX8Py7WPWaARDWSE2gEXcPp3L5R?=
 =?us-ascii?Q?U/2M3yv6a1kXHfPob88P34Jl5OSAfKyXc00eGAyyh2JwDqu2Zu7Wb7IoqFHy?=
 =?us-ascii?Q?j4T2v2ibkaRCKdqOYU5zvrosNawlYWrLG0sUIbvpqLIEcB3UX3iYWEE8ykMu?=
 =?us-ascii?Q?mrdfAh2s59khGSrWYon0JWdJysSRitDlvq+k56yWxoT+HF8dGZX4u/Sm+iwk?=
 =?us-ascii?Q?La6ZWFeQ5LNzYKO5J47oX+0c/Eh9RtaG0SuFAVOTF60yFOFkh+OVuioXX54v?=
 =?us-ascii?Q?ztA6AAs98NmezUONkOZ2D9CTAsgj3PVa3x22LAi19EH2T4eeA9vmHzFu7RK1?=
 =?us-ascii?Q?yC92hubQbG6C9vhu2NB27pVTZKHq3cKxDLVDT4k02hbSry653yNC8XuO6ieA?=
 =?us-ascii?Q?6n9krA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b87a3871-c964-491d-7670-08daa23149f1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:43:00.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 AnRfSMMXg0FMi+f6SoMYs8jw62EBMXv4+s0k7/fNkymT+B8ARADqgvbu8ANZd7ulmXHc4sKpT6uxq/AToyUp1XzUNYSZi7rY7p8pnxHfFlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5946
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Sep 2022 15:43:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9576



On 9/20/22 18:27, Jan Kiszka wrote:
> On 20.09.22 17:40, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>
>> Updated steps to enable secureboot with user-generated & snakeoil keys.
>>
>> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>> ---
>>   doc/README.secureboot.md | 62 ++++++++++++++++++++++++++--------------
>>   1 file changed, 41 insertions(+), 21 deletions(-)
>>
>> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
>> index 319b4db..977377a 100644
>> --- a/doc/README.secureboot.md
>> +++ b/doc/README.secureboot.md
>> @@ -76,7 +76,7 @@ Set up a secure boot test environment with [QEMU](http=
s://www.qemu.org/)
>>   ### Debian Snakeoil keys
>>  =20
>>   The build copies the  Debian Snakeoil keys to the directory `./build/t=
mp/deploy/images/<machine>/OVMF.
>> -You can use them as described in section [Start Image](### Start the im=
age).
>> +You can use them as described in section [Start Image](#start-the-image=
).
>>  =20
>>   ### Generate Keys
>>  =20
>> @@ -113,7 +113,7 @@ cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secure=
boot-tools
>>   to the current directory. OVMF_VARS_4M.fd contains no keys can be inst=
rumented for secureboot.
>>   3. Start QEMU with the script scripts/start-efishell.sh
>>   ```
>> -scripts/start-efishell.sh secureboot-tools
>> +OVMF_CODE=3D/usr/share/OVMF/OVMF_CODE_4M.secboot.fd OVMF_VARS=3D./OVMF_=
VARS_4M.fd ./scripts/start-efishell.sh secureboot-tools

We should integrate the variables in ./scripts/start-efishell.sh as=20
OVMF_*_4M.* has the correct size. See=20
da0ff6630c7f6e48fc82b3766a04992bee7fcafe
>>   ```
>>   4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the followin=
g steps:
>>   ```
>> @@ -147,16 +147,28 @@ For user-generated keys, create a new option file =
in the repository. This option
>>   header:
>>     version: 10
>>     includes:
>> -   - kas/opt/ebg-secure-boot-base.yml
>> +   - kas/opt/ebg-swu.yml
>> +
>> +local_conf_header:
>> +  secure-boot-image: |
>> +    IMAGE_CLASSES +=3D "verity"
>> +    IMAGE_FSTYPES =3D "wic"
>> +    WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
>> +    INITRAMFS_INSTALL_append =3D " initramfs-verity-hook"
>> +    # abrootfs cannot be installed together with verity
>> +    INITRAMFS_INSTALL_remove =3D " initramfs-abrootfs-hook"
>>  =20
>>   local_conf_header:
>>     secure-boot: |
>> -    IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"
>> -    IMAGER_INSTALL +=3D "ebg-secure-boot-secrets"
>> +    IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-signer"
>> +    IMAGER_INSTALL +=3D "ebg-secure-boot-signer"
>> +
>> +# Use user-generated keys
>> +    PREFERRED_PROVIDER_secure-boot-secrets =3D "secure-boot-key"
>> +
>>     user-keys: |
>> -    SB_CERTDB =3D "democertdb"
>> -    SB_VERIFY_CERT =3D "demo.crt"
>> -    SB_KEY_NAME =3D "demo"
>> +    SB_CERT =3D "demo.crt"
>> +    SB_KEY =3D "demo.key"
>>   ```
>>  =20
>>   Replace `demo` with the name of the user-generated certificates. The u=
ser-generated certificates
>> @@ -174,7 +186,7 @@ kas-container build kas-cip.yml:kas/board/qemu-amd64=
.yml:<path to the new option
>>  =20
>>   Start the image with the following command:
>>   ```
>> -SECURE_BOOT=3Dy \
>> +SECURE_BOOT=3Dy DISTRO_RELEASE=3Dbullseye \
>=20
> We should probably flip the defaults in start-qemu.sh now...
>=20
>>   ./start-qemu.sh amd64
>>   ```
>>  =20
>> @@ -194,27 +206,32 @@ To change the boot behavior, enter `exit` in the s=
hell to enter the bios and cha
>>   #### User-generated keys
>>   Start the image with the following command:
>>   ```
>> -SECURE_BOOT=3Dy \
>> +SECURE_BOOT=3Dy DISTRO_RELEASE=3Dbullseye \
>>   OVMF_CODE=3D./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.sec=
boot.fd \
>>   OVMF_VARS=3D<path to the modified OVMF_VARS.fd> \
>>   ./start-qemu.sh amd64
>>   ```
>> -
>> +After boot check the dmesg for secure boot status like below:
>> +```
>> +root@demo:~# dmesg | grep Secure
>> +[    0.008368] Secure boot enabled
>> +```
>>   ## Example: Update the image
>>  =20
>>   For updating the image, the following steps are necessary:
>> -- [Build the image with snakeoil keys](### Build image)
>> +- [Build the image with snakeoil keys](#build-image)
>>   - save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-=
image-cip-core-bullseye-qemu-amd64.swu` to /tmp
>> -- modify the image for example add a new version to the image by adding=
 `PV=3D2.0.0` to
>> -  [cip-core-image.bb](recipes-core/images/cip-core-image.bb)
>> -- start the new target and copy the swu `cip-core-image-cip-core-bullse=
ye-qemu-amd64.swu`
>> -  to the running system, e.g.:
>> +- modify the image for example, switch to the RT kernel as modification=
:
>> +```
>> +kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-se=
cure-boot-snakeoil.yml:kas/opt/rt.yml
>> +```
>> +- start the new target
>>   ```
>> -SECURE=3Dy ./start-qemu.sh amd64 -virtfs local,path=3D/tmp,mount_tag=3D=
host0,security_model=3Dpassthrough,id=3Dhost0
>> +SECURE_BOOT=3Dy DISTRO_RELEASE=3Dbullseye ./start-qemu.sh amd64
>>   ```
>> -- mount `host0` on target with:
>> +Copy the swu cip-core-image-cip-core-bullseye-qemu-amd64.swu to the run=
ning system
>>   ```
>> -mount -t 9p -o trans=3Dvirtio,version=3D9p2000.L host0 /mnt
>> +scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@=
127.0.0.1:/home/
>>   ```
>>   - check which partition is booted, e.g. with `lsblk`:
>>   ```
>> @@ -228,8 +245,11 @@ sda      8:0    0    2G  0 disk
>>   =E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
>>   ```
>>  =20
>> -- install with `swupdate -i /mnt/cip-core-image-cip-core-bullseye-qemu-=
amd64.swu`
>> -- reboot
>> +- install the swupdate and reboot the image
>> +```
>> +root@demo:~# swupdate -i /home/cip-core-image-cip-core-bullseye-qemu-am=
d64.swu`
>> +root@demo:~# reboot
>> +```
>>   - check which partition is booted, e.g. with `lsblk`. The rootfs shoul=
d have changed:
>>   ```
>>   root@demo:~# lsblk
>=20
> Quirin, could you cross-check as well? Seems fine to me on a quick glance=
.
>=20
> Jan
>=20


Quirin


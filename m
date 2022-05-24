Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F9C433F5
	for <webhook@archiver.kernel.org>; Tue, 24 May 2022 16:10:08 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.67])
 by mx.groups.io with SMTP id smtpd.web08.11392.1653408601080301398
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 May 2022 09:10:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=AU6cmvOL;
 spf=pass (domain: siemens.com, ip: 40.107.104.67,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrUSD+4O+vEN3nUdzJDYWfc13wemwtK7vAYGmTrLAweb2dHc4pYbW1/RJmjfVw9sz1ENdojUcCzmACl7zfo5krvbKxXwVp4Ib8yfgXhw0w+LxUdM6FuXUwcipckF2rSZXWB4fMWtFrJCDH1YnRUCFCpaGLqtpz71+7z9uDd8KjvYd0C11uy6czQXmSHylA3nHoithYL6DCro25EChxlC7lPh37JbeCqqNElOeDe2a5JDDDKmjc71OR1g/m6fLp0mrXYNuYYCxsLj2Wf9+Fr0ANu1t5GVvJ5vbaIYB6PYS4Aq9ueV7eu4ztVDlRMi+bhKG0zbnUqkz6IQGhO5BqMkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djpJNFaIWBfhjPT/bzfJuqRHzwnzE72nx71H/12QmT8=;
 b=U1jzP8ynNze+rEVVigM14FxerZolyR6bAJ/iEh+aX+1SPOF+EPZT3hXCA4oslph+7eiM73Tp9qjSLWkkx+M2vdlPWP6WFvgacjxkdBxdu3lUDjsaAZ2JSNhN7NMw+g389NcDkcYX2krdds/chgMl68B+h6WefEIR3sn9BmSZQwYh7GgunhcB6r+c4qLTVzFg/CkJ2kuCLC8AoQrjbX3v1fxZw4r1y0n2/85eRrm3HrlkgtiiI407SsdEv2E3HNEkF8UwgK7+VCsheLpZugaDLVODjmRneLfaHzZvsSLcTsOnHVMQI4hL86n+fB9pN2KIlVpOcaQRWrPZ/1J4g7bF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djpJNFaIWBfhjPT/bzfJuqRHzwnzE72nx71H/12QmT8=;
 b=AU6cmvOL/jBkl5PmDSiJDBvdSddNbKThqxoX6V9j/6rcCV18/BPZ7eCwARWTr/pHUjzit6YsmR+MgBCmpZtDXp9K7a4GbhepDiFW2KQtQf4KNS7TH6p+BtUNakuSR2IxV6yAN/GuZDfOZ1WyhKNUNaHg8DEDtBBPFZMYX2tC2cdqJSl4c2uPIgwhZUsfiuF//AayS9CHlZ7q2wwbJKpd/+ugAOS9Faj9W6vkLImprmec8cTO17ecBn+CMKcgxtOpLwA/zTazAQulaSP07/8DsL9r/pEYi+1MA4P2XeDP7nDbuY59rFi82ubECevolvVTHRpzCE7EYKm3fJn9lYf3vw==
Received: from DB6PR0501CA0034.eurprd05.prod.outlook.com (2603:10a6:4:67::20)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 16:09:57 +0000
Received: from DB5EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::d4) by DB6PR0501CA0034.outlook.office365.com
 (2603:10a6:4:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23 via Frontend
 Transport; Tue, 24 May 2022 16:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT044.mail.protection.outlook.com (10.152.4.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 16:09:57 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 24 May 2022 18:09:57 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Tue, 24 May
 2022 18:09:56 +0200
Message-ID: <34a3735d-4ef3-a07b-0114-a6aa273e1732@siemens.com>
Date: Tue, 24 May 2022 18:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard-efi: Use correct
 search path for the efibinary
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
 <8827c44a-366e-59b3-8062-d2d4b1dd47af@siemens.com>
 <17b20d92-af97-5598-8733-f9c625414394@siemens.com>
 <9cadf05d-a3ad-687c-9fd8-b3715173f2d7@siemens.com>
 <17b1a6c1-d06d-90ac-231a-e9226b28d143@siemens.com>
 <b696c777-be38-12db-8647-02927169c26a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b696c777-be38-12db-8647-02927169c26a@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.007100-8.000000
X-TMASE-MatchedRID: irl7E//xM945QaOxwNGfvo9bHfxDWoibWi7t2dR1S0YaLqFbxdotGQyg
	hFX0lxFwrP7fIroeSfODmItpkInC+sX5dLrRwDRDVPv3/UoKH3sDI91I0N0Y7wPZZctd3P4BJSc
	vOTX4jHNZdl+RWburG+nQk6dUeFKNTfV1RcxxkrQ9qsdubtvoYVL+KwgRcYO/x64UvlSkg3ESp9
	rqY6jeEjL/GHoao0dV0ZVCudkmoh4QQrxeVqUQQAH3zZVGDAWmgoTNcgEj13g4hD0Y/Y/a78nlJ
	e2gk8vIC9lxI7Zs/OljLORo1y6rxh4XWidIQNbzi0OtMWeidwn36GblkZtA0ZV3j1zTOBYzYBba
	P1VZzSWUAUfla+IhaLKXWmEvaG3ElyyR46PvItO2qNGaLuHnvr9ZdlL8eonaVnRXm1iHN1bEQdG
	7H66TyH4gKq42LRYk09i7S+goGXgF/g20MlHBbql5JhSGQ5yerzo+SbIbIv9+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.007100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 238ADF314E05ADB1FE7B4D7420045788A6470C4AB5BC7658339172C7216849642000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 220ac710-db0e-4d55-a77e-08da3d9fd91a
X-MS-TrafficTypeDiagnostic: DB4PR10MB6263:EE_
X-Microsoft-Antispam-PRVS: 
	<DB4PR10MB626302D23A39863BBAA14A1495D79@DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i6mxCYcTgl/YM33c+XKBRJZmmbzRoo0HDlRW1LebjaH6cJ3gTvZSSN6ySlH2ijvEv2PwDQWAjxucTGQvIk1zGUGttjNiMfwXagXsOO+PtBlfxFZ8feDRtolZX6mC/tj12Um//rwjrM+KYEd+6/dYqIUJuTyYmmaprwaUuRg/rb+RlgMK5iXl8H8soJ0K68k0HDMa452cGKKt/eYKpHVoycVCdAJg65LxMRH5qhp2b0S/69tmWNqdGLwDPf3/C5qVag0ajNL1gA4jO5M727j5n9Q3oOUFNQOcLJPiqeNU3vadVNUcSkebRqyb8i9hxmGMkaNxaINAiHwh9gztDOBfTa8px+NwXrwS9fj/Orj3t3saDPHwokpJYE9cS+DpnIhEZ7ruceeTms5vp7Q2g9FDUN4fLLGwyhGPwtAMVBwRxK8CERPkjJHmvZrSNkAPZO/TEuW2kx8VUaTd/YyC52PxRP71SO1sSme7Dw0IVwQ6TIzuaib8jg4NLicAuQzjmN0BaWijt5HvaSBMv6P/G31k+pPNDtrxs6lf7hUjjKYU7zJpaE2pENm1AgahT8d+F7WqL5ZB1lKs6yQ3V7Ny/yIj/FyftRhkoVxHlw/uwyO+pdnHx1jI7Nkw15AGTfZkRDKNuwfeoNYnRrZDD5DDb+y+maxLUasLovAqUMId/p3kDRwwT5PiyKVAyzrqUuoRedILHWcf5uEebBYlszocPuumAqxsvsgS/0bDR4KXd3xSjLU4IEI89sRN5txLMy/j6QcQuqNY9E91Q54VcmNo/5IQH+jBZ4SbcH8Hn0Tw86OQXTtfmZDv3ctuxM8y/ZuNH2Brz4R3eX5Ysln8tmmrRFA5sIy28kElbvS5mjHMrdxWsshz3PvkTgZBstQglXWREF11XOxj/Q31kSooqNxTBOTT3A==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(186003)(16526019)(44832011)(47076005)(956004)(2616005)(86362001)(26005)(53546011)(31696002)(81166007)(82310400005)(40460700003)(356005)(82960400001)(36860700001)(83380400001)(5660300002)(36756003)(8676002)(70206006)(70586007)(316002)(16576012)(8936002)(508600001)(966005)(110136005)(31686004)(6706004)(2906002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 16:09:57.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 220ac710-db0e-4d55-a77e-08da3d9fd91a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 May 2022 16:10:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8435

On 24.05.22 18:03, Gylstorff Quirin wrote:
>=20
>=20
> On 5/24/22 17:50, Jan Kiszka wrote:
>> On 24.05.22 17:38, Gylstorff Quirin wrote:
>>>
>>>
>>> On 5/24/22 17:23, Quirin Gylstorff via lists.cip-project.org wrote:
>>>>
>>>>
>>>> On 5/24/22 17:07, Jan Kiszka wrote:
>>>>> On 24.05.22 16:57, Quirin Gylstorff wrote:
>>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>>
>>>>>> This fixes the build error:
>>>>>> ```
>>>>>> ERROR: _exec_cmd: cp /usr/share/efibootguard/efibootguardx64.efi
>>>>>> /tmp/tmp.1Y4utA1zC2/sentron-product-sentron-sentron.wic/tmp.wic.ampn=
awp6/bootx64.efi
>>>>>>
>>>>>> returned '1' instead of 0
>>>>>> output: cp: cannot stat
>>>>>> '/usr/share/efibootguard/efibootguardx64.efi': No such file or
>>>>>> directory
>>>>>> ```
>>>>>>
>>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 =
++++--
>>>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>>> index e1411cb..a01e484 100644
>>>>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>>>> @@ -59,8 +59,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_=
arch =3D get_bitbake_var("DISTRO_ARCH")
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>>>>> "/usr/share/efibootguard/efibootguard{}.efi".format(
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
distro_to_efi_arch[distro_arch])
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootfs_path =3D rootfs_d=
ir.get('ROOTFS_DIR')
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>>>>> "{rootfs_path}/usr/share/efibootguard/efibootguard{efiarch}.efi".for=
mat(
>>>>>>
>>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
rootfs_path=3Drootfs_path,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
efiarch=3Ddistro_to_efi_arch[distro_arch])
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_ro=
otfs_dir =3D "%s/disk/%s.%s" % (cr_workdir,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.lab=
el,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.lin=
eno)
>>>>>
>>>>> Makes sense in first sight - but why did it work so far? Or did I mis=
s
>>>>> to test one of the two cases (signed/unsigned)? Did you test both?
>>>>>
>>>>> Jan
>>>>>
>>>> I am still try to find the reason why it work in isar-cip-core. The
>>>> error occured in a downstream project.
>>>
>>> In isar-cip-core the error never occured as we install `efibootguard`
>>> as a dependency for wic[1].
>>>
>>> efibootguard-boot uses the same logic[2] to access the kernel stub.
>>>
>>>
>>> We should decide which is the correct way. I would prefer that we take
>>> both stubs from the buildchroot.
>>>
>>
>> Yes, the preferred source for bootloader artifacts should be the
>> buildchroot and NOT that target image. We are currently installing more
>> on the target as practically needed. If that should ever change, things
>> shouldn't break here at plugin level.
>>
>> Jan
>>
>>> [1]:
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/kas=
/opt/efibootguard.yml#L24
>>>
>>>
>>> [2]:
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scr=
ipts/lib/wic/plugins/source/efibootguard-boot.py#L190
>>>
>>>
>>> Quirin
>>
>=20
>=20
> Should we move or reuse the files from salsa[3]? There the binaries are
> part of the dev package[4].
>=20

I don't think sticking the bootloader into the dev package is correct or
in line with other bootloaders (grub-dev? system-dev?). The main ebg
package should contain the bootloader, and if we want to split the tools
from it, that should go into a separate package.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


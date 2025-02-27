Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F71C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 08:19:07 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web10.6210.1740644343177781244
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 00:19:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Tk/HtXiq;
 spf=pass (domain: siemens.com, ip: 40.107.20.69, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZWDkEZzFoRHJI4X4blVvhgPywmC/tVZFueYZJy3SFiZ9l6tSzO1b0jwdt99E240PCNid5UN4A0/WSMkcYaozehAxKCt+gZU6ZRJytbIGfBmR/Mi/P2cdr7YDex3gZAbxLSq4lmen8ksKGFkyeUmaD3Sq5idry7u9iaxjdvuj6wywBy33rExyeUh3mu1e2cYsLGjWvnNhag3sJIbeWj8SM4bAtKyEfU3QTc+rh8QZyvYiqBkFKHHKBqqtpHlAsbojqfJMYu1sC1NVwMk5kLK/DlofTntQ8vg+g/1UDUbysTP5avngdNchTd1KNLPMJwMTNGQew3by4pIIzhmSz4GQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU8IegSC1DUi4f3mvyZGliNqBwFQ57ry7C/a19bZT14=;
 b=obYqzjlQ2O+4QVNuCyFMpAkyvZgH9jNz6RxihmPSBbqiPW8uWwGHwCcLKmaSpfAXvkc4voD08974LDFhHroInQqcgLCChr2l2M7VMEDSgZyOmW5vqufReknD5fF5LVSYpYOYi2Irxu6/94hdAPGYWW5bFr1bmM1L5vZ4BeP2rJTPKxZwWBQ0ZORVMcorDB+X1RcoCeviHpltg43ZqJRutFOuccsPKWOC19cT11sNC6qsMsCA4UjEYItY58KddI9dcydJzSeL0UFoEzvlV1Kg/cXOcMqsoW6H1wYnoz+RpsVUObA+hNWqJIm0/CNpI/fenIHClvrt2+cDbAubNAJcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU8IegSC1DUi4f3mvyZGliNqBwFQ57ry7C/a19bZT14=;
 b=Tk/HtXiqGiAHVqM7Ny6EdhOTNyu19QRm/ipMhcxmKyFvKsNTtmN4by1iCSlCXzqEvpmoeHXjFeLIQvFbQ9fp3T0WOb/OVPcz9cQX28QV6Kifk8U1lkEESQg7dMR2x8+2G42yHonUwJMznydhvWHYCTcZXwUGbsZQc7qY6oVevnB3a+dk42nE/eiFQZsrWr4yLpcPB0ysnrmIwgsfAs4KBZly+L7sjPpuXyXhtkv6ah3OqZO22iet6V0NHP9UCuAQ3eeO+XhNPU9n9GAe2tOsKGagKkWNOFc0YEAtBsSctligI5XPr245XhpSPSy1nWQ8szNt0ghKzDip96nRzLoq/A==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by DB4PR10MB6094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Thu, 27 Feb
 2025 08:18:59 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 08:18:58 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH v3] initramfs-crypt-hook:
 Optimize disk encryption in combination with expansion of last partition
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v3] initramfs-crypt-hook:
 Optimize disk encryption in combination with expansion of last partition
Thread-Index: AQHbiKYrs69lsQmhTkinNrMPdw+Aa7NaUOkAgAB9FHA=
Date: Thu, 27 Feb 2025 08:18:58 +0000
Message-ID: 
 <AM7PR10MB3320BBEC70D8B883122284FE86CD2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20250226232812.374892-1-alexander.heinisch@siemens.com>
 <CAK9C7GBj+Ovxx9GqS842OMqzKC7Yfn--6=yQMc8mnDHxMrt38A@mail.gmail.com>
In-Reply-To: 
 <CAK9C7GBj+Ovxx9GqS842OMqzKC7Yfn--6=yQMc8mnDHxMrt38A@mail.gmail.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=222dcd74-200a-46b1-948d-d08a5f187613;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-27T08:14:38Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|DB4PR10MB6094:EE_
x-ms-office365-filtering-correlation-id: 3cf2e184-f325-4c40-e053-08dd57076297
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?IPG32pAFXpDVx6WxfUxpiyJuYOnxnZUrwuM+WSQr2Er/0hL5Uj+HoEjJLw1e?=
 =?us-ascii?Q?+HDC4I8jlhJeQezzM7QGa6DAVKkZ6SBGesI+ac3LkSsm1iMtAk/sFaYAZPkT?=
 =?us-ascii?Q?emJBYNiuSzCvZgOOT45TrVZnyLtfClGKRdyFJYmGM92V8GzAZ+xLr3eYk8uc?=
 =?us-ascii?Q?qjxGa1SzxjV0CDCY/vpoWSxrpanHjksRDclTIBNb6Sz9i0B7Qa7/APopb13A?=
 =?us-ascii?Q?gtqXDjct6xRcgYcHamIFjdNaMPgukHqKTvrCaZ5EP2zaLWimdqIW/P9JJY3W?=
 =?us-ascii?Q?qkCRe6Llxy5LmVgc+k5XGBRXUMtd1qa7kJzia3LoySOAfltb3KElBrFuriSo?=
 =?us-ascii?Q?7f7+3gSEK8sFpuL1sJyvfzbMD9fspoDhSzp8BUqX/LbiTIRitt+Q7e67me5+?=
 =?us-ascii?Q?ntHpMCUggYtCDLZoYyf8K6gDDmO8wm+Ezlu8GaLAXZwCV1uTr3JYTFDxW5px?=
 =?us-ascii?Q?/4fCtK+TVUUHKK9p2O3r9G1jEFRvswlwF0capjvTIOQDVPnXxYpOSEao5l1u?=
 =?us-ascii?Q?BIixcyhz1g8qaZIsRq5BLRxO6+/aou3Zqm+iPNj4A+V2XKSuXBhVDX1YsiSP?=
 =?us-ascii?Q?Kr/up6tl0uqpUj/Y5xnBcWTE2SAivC6TSTWtyCSlKk5Z8B+bjYnkbf5ejXGm?=
 =?us-ascii?Q?bN0NocsIxd15CddL0gfCEMb1imbdwCeKLEWFZYCNTbMoqWT4sd44V27NBTw1?=
 =?us-ascii?Q?KBHprV1ObgDxMCpRaNKl2r0s9F9iOMPfFp0t0DTJOaZAd4dP/HPdK5iEP74p?=
 =?us-ascii?Q?OiSONRodEMhWY3fpyuLoeQT1S1QySA4TiMSnLLfFg4OPUZK6hbhTapU8xKEJ?=
 =?us-ascii?Q?53Z+bTsgfzvhkMW9El941LNBltXY7apZo9GtJn9yOl32Gno1LcRBsLMllG4e?=
 =?us-ascii?Q?MqcO5LaCXjk03WWva1xCaI+r7ndB8y0aljc68jyW23LggSCBdPdb3LGZE6dU?=
 =?us-ascii?Q?AdVEWzlteTDAL8qtpclCbtXiYsT1WtGwOzMdfxkcduK7aRIE8f7ionzdg9FA?=
 =?us-ascii?Q?qJ/uDKmdBEzv6YKlffkNWAiF5Nl8ZoRKGvrjL7eMDjljdghmzt/ZAXqjZkH3?=
 =?us-ascii?Q?tcIHYS7jifGfEGsvAAodb3WziYItgNPp5Vk05BJr/HtAjJA9QAX8kbAsuGQ7?=
 =?us-ascii?Q?0q+sdP1j+bsKp5UvrefdMuge2tJaMbrvCjrA9541/P1BO5Bfc1Q/f7mBU+/5?=
 =?us-ascii?Q?rGPtg2XbPOHgyTgj5kQnIhkSaSgVNPqAF969p/Pjt7E8x7a6LA+RZr8sDqFj?=
 =?us-ascii?Q?IgUJNa/3xk8aOKCntVzp/idx/M298opZNF4mgWR+lVbSMd1yaShXeFF7NWbW?=
 =?us-ascii?Q?rzXgW/MPVS6odEpS4NgYbgVLLUL5YNJyctbupS/HP1/Dd7LAFRUpC/fdcMad?=
 =?us-ascii?Q?Lo4BvAHmfvNl/RJ+Vj4qI2YBwyiRw6U6QW4oT0oma8hDMO+xHBgPWin3b8az?=
 =?us-ascii?Q?ZPL2hwtP2oCzOginVfSMWb2hjmNgT71v?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kkM3gNsDYrW1NIMgCwB1JVGNonezRm2OVz29r3yeg4aKNFb6HB/BtTexWTZ0?=
 =?us-ascii?Q?CmwRrkvlOafiMND9Z4MCk9qfWEdAM4FdN8VtLg0MB3H6PLXPo62GoNxSfc7P?=
 =?us-ascii?Q?eReNAO2CjIxc8YxGNxNzufxOI5diizDzr31dRMqG4bnMB9AviV5pXta0ufRH?=
 =?us-ascii?Q?g0yHh+lkT6a/Bn2sVUhUoluOMWEQz5QEk3h2UGrdV3to2E8OGJRzyk0RSo5w?=
 =?us-ascii?Q?Lhm//WzpcgJZqfRKp0hpxTki3uBtYmKQxWezSLaoCBQ2oQ0Plzd8wniOcRY2?=
 =?us-ascii?Q?z/3WR/KCIEpeKGG/Pts9WLOQB7Kxy/7kCbgddGSKLtMGdBPmtDwFbKhh2xE6?=
 =?us-ascii?Q?Bkm6RX1Q1ix3Q4hjGwHMcKZD4KxITdJmJahfV6Z1rSYCCHbKGsS/UPxlpRWu?=
 =?us-ascii?Q?dDpfmj9mYzpbUlm1PRyul5eAmGas2liF7VG/e9jwpEfIIQPQ61mg0FTalwJr?=
 =?us-ascii?Q?yh9L2SO94b3F7rY60tYxqNOP83W5LTER1K7eIgCHd9gD+QstGVGt6slhZce4?=
 =?us-ascii?Q?HILgAea7LZD6P3/Bh48+KdQoFr+9cXiawOXMgPf1MtoNVF9UYE9ouzRGyyjW?=
 =?us-ascii?Q?WYXtF8tpGzXfHY6bz45+sMa3WgcGnnzWhWsw/6qeVRg8XvXNn6eX03HAI+JN?=
 =?us-ascii?Q?qB0IqPKqWyhYFML5YPnSrARRAvz/H14tIqjttv3G0It6Zwb2PZGjH6XHopRM?=
 =?us-ascii?Q?+CziMJW0WPSoOgnp63/1o+AjnFMRDrFoMS4nuF5dUaW5nol7FI7pYF9LEJEM?=
 =?us-ascii?Q?y6sfplLbUp10AFg6Z89dTa3CMF8Uc7eUdnywXcuuMu2GU+9W37uw10L99EsK?=
 =?us-ascii?Q?z3khUZSLZ5dvqYA8oU8mwtUQK8zyMKNasjQ7QPI790BAQrmRRmpT2alRmiGE?=
 =?us-ascii?Q?ukwamVmMCMeU5iBDlvdngTgjlACxNeIsGw4klpo/mUlEVoWJKwk9uTmI8Fz1?=
 =?us-ascii?Q?3gPZm1Nu9Se1iNKL0t7efXiyXKkzCgG8e3RnaiMxHqSyumWgquuVv1+lALNS?=
 =?us-ascii?Q?2evMNFE9cD3i0C1FxFiawnfetqRqSwsngQacFp4kX7zyXzWtFNkItj0ubsh/?=
 =?us-ascii?Q?hFdgvVwg7FLdUK3mUHAvT6sM4qP/YZqZolEyAL5cKfSq+XXNn1s+yFJhBMdT?=
 =?us-ascii?Q?PAH7QaW0kQx+kgfVuEV7lUvYd6VcaKOEfVPfb0gQ1W0hhrfhMx3EGz6GyLL+?=
 =?us-ascii?Q?dmd/UNzwkhACFQAWkF0J9GtWzcKmObNFgd5d3E4D+WAWpb+IrPvGxtPybjK8?=
 =?us-ascii?Q?ui3J/DK7k8h2puu3PMHp93A2jd97v314nee320LUHl/uNaObD3Xc1wMyvPYR?=
 =?us-ascii?Q?WqdL+HWhPXCO1uUE7R2Kg8ddsTtE1pIrjCfo3zjTJtDVCO/4TNtQpD7/QNkR?=
 =?us-ascii?Q?lJi/qUEDiN2HZQ0zfWMcGTuiublboN4uahKRHf+XYmsY1rH7JdLLx3xbr8JK?=
 =?us-ascii?Q?fXRl4szZdfzUMCmdmnbz0ijFMrVSlrmoOLWZunCshKyKGAwA58/JZdgo6C7x?=
 =?us-ascii?Q?83leDIiIzc0/KY2IDZgsmz3cxIDDgAjIkN+emNiqnQbu4A3ZKve0uNamQP3j?=
 =?us-ascii?Q?uUkHIfYT9gqRfDoJxggRie7/VOtaNAu9jHfLYkAc18Kkh6V0I0dbgHFgoHow?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_AM7PR10MB3320BBEC70D8B883122284FE86CD2AM7PR10MB3320EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf2e184-f325-4c40-e053-08dd57076297
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 08:18:58.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9tX6zXc6TGOGd/gRvzLYkSJ1vINxFkR+w8H8XNwbLovN6s58CVpQqa8WxeGohg/1z2fLSg58wNe1Ht9Qe/AuXhI9r+MT8aSDNfC6yKq4bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 08:19:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17927

--_000_AM7PR10MB3320BBEC70D8B883122284FE86CD2AM7PR10MB3320EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Is that right?  I presumed it was encrypting the entire disk, not just pa=
rtitions on the disk.

This patch does not change what gets encrypted!

You still have to specify on a partition base (e.g. `CRYPT_PARTITIONS ??=3D=
 "home:/home:reencrypt var:/var:reencrypt"`) which partitions get encrypted=
.

BR Alexander

>
>> On Wed, Feb 26, 2025, 5:28 PM Heinisch, Alexander via lists.cip-project.=
org alexander.heinisch=3Dsiemens.com@lists.cip-project.org<mailto:alexander=
.heinisch=3Dsiemens.com@lists.cip-project.org> wrote:
>> From: Alexander Heinisch alexander.heinisch@siemens.com<mailto:alexander=
.heinisch@siemens.com>
>>
>> In the current implementation (since: 284175c3) disk expansion logic
>> is done before the actual disk encryption.
>>
>> This results in reencrypting the full expanded size of the disk, instead
>> of only reencrypting the sections containing the actual data. This resul=
ts
>> in a drastic increase of time (approx 20x on our systems ) needed for re=
encryption!
>>
>> Since relevant disk contents are only available in the sections of the d=
isk
>> available before the expansion, it is sufficient to reencrypt them only.
>>
>> This patch changes order of encryption and disk expansion resulting in
>> faster encryption (since only the necessary parts are encrypted).
>> The resize operation does not reencrypt the added disk parts but just
>> extends the LUKS container (cryptsetup resize) to reflect the maximum
>> available disk space.
>>
>> Signed-off-by: Alexander Heinisch alexander.heinisch@siemens.com<mailto:=
alexander.heinisch@siemens.com>
>> ---
>>
>> Changes v3:
>> - Provide key to cryptsetup resize for clevis based setups.
>> - removed export of EXT2FS_NO_MTAB_OK=3D1
>> - Added support to expand partitions with btrfs
>>
>> Changes v2:
>> - Reuse get_fstype from mkinitramfs scripts/functions.
>>   Therefore, we could also get rid of mounting the partition
>> - Dropped support for btrfs (compared to v1) since crypt hook
>>   does not support btrfs anyways
>>
>>  .../files/local-top-complete                  | 37 +++++++++++++++++--
>>  1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-comp=
lete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 5ef7ca4..fac6db6 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -102,6 +102,8 @@ reencrypt_existing_partition() {
>>  }
>>
>>  expand_partition() {
>> +       key_file=3D"$2"
>> +
>>         boot_device=3D"$(echo "${part_device}" | sed 's/p\?[0-9]*$//')"
>>         last_part=3D"$(sfdisk -d "${boot_device}" 2>/dev/null | \
>>                      tail -1 | cut -d ' ' -f 1)"
>> @@ -155,6 +157,33 @@ expand_partition() {
>>         # Inform the kernel about the partitioning change
>>         partx -u "${last_part}"
>>
>> +       last_part_device_name=3D${last_part#\/dev/}
>> +
>> +       mapping_name=3D$(cat /sys/class/block/"$last_part_device_name"/h=
olders/*/dm/name)
>> +       # systemd based systems do not need to have the
>> +       # key_file provided since systemd backend for
>> +       # cryptsetup resolves the passphrase directly
>> +       cat $key_file | cryptsetup resize "$mapping_name"
>> +
>> +       last_part_mapped=3D/dev/mapper/"$mapping_name"
>> +       fs_type=3D$(get_fstype ${last_part_mapped})
>> +
>> +       case ${fs_type} in
>> +       ext*)
>> +               resize2fs "${last_part_mapped}"
>> +               ;;
>> +       btrfs)
>> +               mkdir /.mnt-tmp
>> +               mount -t btrfs "${last_part_mapped}" /.mnt-tmp
>> +               btrfs filesystem resize max /.mnt-tmp
>> +               umount /.mnt-tmp
>> +               rmdir /.mnt-tmp
>> +               ;;
>> +       *)
>> +               log_warning_msg "Unrecognized filesystem type ${fs_type}=
 - no resize performed"
>> +               ;;
>> +       esac
>> +
>>         log_end_msg
>>  }
>>
>> @@ -217,10 +246,6 @@ for partition_set in $partition_sets; do
>>                 echo "ROOT=3D$decrypted_part" >/conf/param.conf
>>         fi
>>
>> -       if [ "$partition_expand" =3D "expand" ]; then
>> -               expand_partition $part_device
>> -       fi
>> -
>>         if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>>                         | grep -q "luks2"; then
>>                 open_tpm2_partition "$part_device" "$crypt_mount_name" "=
$tpm_device"
>> @@ -260,6 +285,10 @@ for partition_set in $partition_sets; do
>>                  ;;
>>         esac
>>
>> +       if [ "$partition_expand" =3D "expand" ]; then
>> +               expand_partition $part_device $tmp_key
>> +       fi
>> +
>>         finalize_tpm2_encryption "$part_device"
>>  done
>>
>> --
>> 2.43.0

--_000_AM7PR10MB3320BBEC70D8B883122284FE86CD2AM7PR10MB3320EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE-AT" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt; Is =
that right?&nbsp; I presumed it was encrypting the entire disk, not just pa=
rtitions on the disk.&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">This pat=
ch does not change what gets encrypted!<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">You stil=
l have to specify on a partition base (e.g. `CRYPT_PARTITIONS ??=3D &quot;h=
ome:/home:reencrypt var:/var:reencrypt&quot;`) which partitions
 get encrypted.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">BR Alexa=
nder<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 On Wed, Feb 26, 2025, 5:28 PM Heinisch, Alexander via lists.cip-project.or=
g
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><a href=3D"mailto:alexander.heinisch=3Dsiemens.com@lists.cip-project.=
org"><span lang=3D"EN-US">alexander.heinisch=3Dsiemens.com@lists.cip-projec=
t.org</span></a></span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">
 wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt; From: Alexande=
r Heinisch
<a href=3D"mailto:alexander.heinisch@siemens.com">alexander.heinisch@siemen=
s.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 In the current implementation (since: 284175c3) disk expansion logic<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 is done before the actual disk encryption.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 This results in reencrypting the full expanded size of the disk, instead<o=
:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 of only reencrypting the sections containing the actual data. This results=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 in a drastic increase of time (approx 20x on our systems ) needed for reen=
cryption!<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 Since relevant disk contents are only available in the sections of the dis=
k<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 available before the expansion, it is sufficient to reencrypt them only.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 This patch changes order of encryption and disk expansion resulting in<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 faster encryption (since only the necessary parts are encrypted).<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 The resize operation does not reencrypt the added disk parts but just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 extends the LUKS container (cryptsetup resize) to reflect the maximum<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 available disk space.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 Signed-off-by: Alexander Heinisch
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><a href=3D"mailto:alexander.heinisch@siemens.com"><span lang=3D"EN-US=
">alexander.heinisch@siemens.com</span></a></span><span lang=3D"EN-US" styl=
e=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 ---<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 Changes v3:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 - Provide key to cryptsetup resize for clevis based setups.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 - removed export of EXT2FS_NO_MTAB_OK=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 - Added support to expand partitions with btrfs<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 Changes v2:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 - Reuse get_fstype from mkinitramfs scripts/functions.
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp; Therefore, we could also get rid of mounting the partition<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 - Dropped support for btrfs (compared to v1) since crypt hook<o:p></o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp; does not support btrfs anyways<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp; .../files/local-top-complete&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 37 +++++++=
++++++++++--<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp; 1 file changed, 33 insertions(+), 4 deletions(-)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-comple=
te b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 index 5ef7ca4..fac6db6 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 @@ -102,6 +102,8 @@ reencrypt_existing_partition() {<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp; expand_partition() {<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; key_file=3D&quot;$2&quot;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_device=3D&quot;$(echo=
 &quot;${part_device}&quot; | sed 's/p\?[0-9]*$//')&quot;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_part=3D&quot;$(sfdisk=
 -d &quot;${boot_device}&quot; 2&gt;/dev/null | \<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tail -1 | cut -d ' ' -f=
 1)&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 @@ -155,6 +157,33 @@ expand_partition() {<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Inform the kernel about =
the partitioning change<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; partx -u &quot;${last_part=
}&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_part_device_name=3D${last_part#=
\/dev/}<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_name=3D$(cat /sys/class/bloc=
k/&quot;$last_part_device_name&quot;/holders/*/dm/name)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # systemd based systems do not need =
to have the<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # key_file provided since systemd ba=
ckend for
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # cryptsetup resolves the passphrase=
 directly<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat $key_file | cryptsetup resize &q=
uot;$mapping_name&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_part_mapped=3D/dev/mapper/&quot=
;$mapping_name&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fs_type=3D$(get_fstype ${last_part_m=
apped})<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ${fs_type} in<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ext*)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; resize2fs &quot;${last_part_mapped}&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; btrfs)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; mkdir /.mnt-tmp<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; mount -t btrfs &quot;${last_part_mapped}&quot; /.mnt-tmp<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; btrfs filesystem resize max /.mnt-tmp<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; umount /.mnt-tmp<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; rmdir /.mnt-tmp<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; log_warning_msg &quot;Unrecognized filesystem type ${fs_type} -=
 no resize performed&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; esac<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; log_end_msg<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 @@ -217,10 +246,6 @@ for partition_set in $partition_sets; do<o:p></o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; echo &quot;ROOT=3D$decrypted_part&quot; &gt;/conf/par=
am.conf<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ &quot;$partition_expand&quot; =
=3D &quot;expand&quot; ]; then<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; expand_partition $part_device<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 -<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if /usr/sbin/cryptsetup lu=
ksDump --batch-mode &quot;$part_device&quot; \<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | gre=
p -q &quot;luks2&quot;; then<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; open_tpm2_partition &quot;$part_device&quot; &quot;$c=
rypt_mount_name&quot; &quot;$tpm_device&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 @@ -260,6 +285,10 @@ for partition_set in $partition_sets; do<o:p></o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; esac<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ &quot;$partition_expand&quot; =
=3D &quot;expand&quot; ]; then<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; expand_partition $part_device $tmp_key<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
 +<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; finalize_tpm2_encryption &=
quot;$part_device&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;&nbsp; done<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:11.55pt"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif">&gt;&gt; --
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&gt;&gt; 2.43.0<o:p></o:p></span></p>
</blockquote>
</div>
</div>
</body>
</html>

--_000_AM7PR10MB3320BBEC70D8B883122284FE86CD2AM7PR10MB3320EURP_--


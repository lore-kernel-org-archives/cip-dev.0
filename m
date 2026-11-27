Received: from OS8PR02CU002.outbound.protection.outlook.com (OS8PR02CU002.outbound.protection.outlook.com [40.107.75.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17150.1795791354809677684
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2026 06:55:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FUU5qj0R;
 spf=pass (domain: siemens.com, ip: 40.107.75.22, mailfrom: badrikesh.prusty@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S30YjSX8vuARxI3NXG31Tvj77cMDzRinNXN61XCtNHyim46nraedlg7wHGFHLTbGFYUBtwuEpfz1NL5EqQHxi2LXD2Hu9siWAzQmxrnOcihksNpKt/gjc3ZtSCXwTFE4JFjbFl5g3EQmE3LvFbYpIVLHtS55TyMLQoXf/Hr3IPoOPRpfKMBPP8Ae56EHvLF1Cc9fMTuqsQN2/bNllAhdAdflsuS5lHKABkw8eWc4fm2S5zMDzk8ePDG5DWWIdLJcepDLOnkqWXIbSf4xOPI4UBn3LZ+LatF0SlGI+6Y22wBDdcVl2X4e+jeKwpzWiGEuy+M1X26k+0+R/EOXgk1sfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVZit0ALmWxlj1qIl4IqTJKOIvxOkaHXk9ZDSHe0sm8=;
 b=p1wHoodvj7ktUHU4drMX+bxgkdvrs6J4V9IQRPsUohgqDevVb6+Czoa3R6JyQcAzuXs4nY71tKkncSV2SWoUwRIhJ3cQ3dZKHxKER/UM9NSkBQm9qZgHWu/KTC927YxZHPTBhPKOtCAMJ5m4cpvYsMV6QIciTdanBGJlSV2fyBOVOCv/xESrgCzM93C3Ds1UQELYfDrDSGowv+QCqVYFo7TEBWx+6JETAWNbz351JdyzfEAoJdKWWLuwc2hoPJl4G9tS9FvfTqBkqBBBgeaRNeiiAowFhmk9gp3Mx7sdBkQH93d2C39vGNinlCLUcYrwygsqRuTUK83UdbY2GqjefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVZit0ALmWxlj1qIl4IqTJKOIvxOkaHXk9ZDSHe0sm8=;
 b=FUU5qj0RZK2WkC+S9kVPJTmfSAUbBZER8hQvjAFinEzvPW7SWlO6MZegSjUB8vzYsqMc5CmL60U8TWLOoyYRHgsR09pyqfWOY1zS4yYqUYKXt4+bo8Xf5SifyzYXmosvYJOxk29UU8dQpxtgRHzRlS5eJ99+E0zYSO/3jw8Z/VFgwykFDpDg9JOF+/vMmlgYaQ0n6DUvUON1FRkCjBcuYvle62C8xmh1z7zT7hywuHn65N/vgiiKllRcgbtrfd0uExLpHVr3WH7zflGxdMts7YeCv9ZmAAyWDi5oNlyesjR08P+cvculBrJFecxX4SncYxC8589jlxMursnTeg6fDg==
Received: from JH0PR06MB6656.apcprd06.prod.outlook.com (2603:1096:990:2f::7)
 by OSQPR06MB7991.apcprd06.prod.outlook.com with HTTP via P2P; Fri, 27 Nov
 2026 14:55:48 +0000
Received: from JH0PR06MB6656.apcprd06.prod.outlook.com
 ([fe80::6009:8c68:86fa:d195]) by JH0PR06MB6656.apcprd06.prod.outlook.com
 ([fe80::6009:8c68:86fa:d195%5]) with mapi id 15.21.0688.004; Fri, 27 Nov 2026
 14:55:48 +0000
From: "Prusty, Badrikesh" <badrikesh.prusty@siemens.com>
To: "Moessbauer, Felix" <felix.moessbauer@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy
 SWU_ROOTFS_TYPE artifact alongside swu
Thread-Topic: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy
 SWU_ROOTFS_TYPE artifact alongside swu
Thread-Index: AQHdfaly32ckXXAvg0is+pEMaO2x7rdAhVQAgAF7/Is=
Date: Fri, 27 Nov 2026 14:55:48 +0000
Message-ID: <JH0PR06MB665630B35273DCD1169D7D0391412@JH0PR06MB6656.apcprd06.prod.outlook.com>
References: <20261126132340.121225-1-badrikesh.prusty@siemens.com>
 <f2b2d5c13790a1ebad1ad21c72ecb0f236b5e180.camel@siemens.com>
In-Reply-To: <f2b2d5c13790a1ebad1ad21c72ecb0f236b5e180.camel@siemens.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-11-27T14:55:48.782Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-traffictypediagnostic: JH0PR06MB6656:EE_|OSQPR06MB7991:EE_
x-ms-publictraffictype: Email
client-request-id: 8f71797e-b078-4901-8f36-c5ce59143e3f
request-id: e815f681-54bc-4eb6-e4a7-08df4c9685ce
x-ms-office365-filtering-correlation-id: e815f681-54bc-4eb6-e4a7-08df4c9685ce
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261022075727099003|11063799006|261022115727099003|261022105027099003|38070700021|10067099003|261028144727099003|4143699003|261026140227099003|261026130827099003|56012099006|261026135527099003|261021135927099003|261022113327099003|261021130227099003|261021121427099003|261021133027099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|18002099003|55112099003|22082099003|4133799003;
x-microsoft-antispam-message-info: yzUuDJc/hZ1FAbskKV2VEWkpJ6ZdcKyNACnutA57w5qd55r5g1hlqOCZE9J+T7wzMiCy0KrrkGAc378QJdrUtzMkgf2zxxMiOTzhQa60Q+tIHxXrAGSc1FWArVBcB3SUxNhZ8VobKXJ9jp4XyURESMWMwUd1F80H8NW7EjWDBeqi1GHZ3nON4mEXyX9vNJhIBtO0BDyclq3yVamg4Ga/TovuxfZOzGrgrl5IeOpAwIEKpJpkUm4fUMSusGoVCwY0P5fNXRjuFyXwnWC/kdK4cRN7S8Kopv5lUmj/UDPqSdGNUglLpIEocC/ApgHhL6fxg8kXWAsaj9saIWqpq6ldSQ5izWBWS/Nz4IxtCH7JGJNz+5Gesq0D0Jh1NHAOc7bu0OQZJOYbmOEaCSKrEirVoA90R/nVcs8C/vRCDaH40S3CsxgD5zVsUQ41kFP2qWImyJ/kg19GgtDnufXfXSV7LwGW22zV4rA/572LIMhIDkbWxGmqC2ulqdPE8loIHwGjMGpMNESZiDTAk2PmKFIgl3WDO3ldoBDYK0xZ+GEH2tSwYAcecsp4m8AFa7ESvZ2CvuL7BPRERSZbjrqB5OOAZWM0NZvze+74c1VYXa4HZlhSTZTFn9+K6n/xQ3f8IvuHvNfmob/SkkLuhEeYZnk0GC1rcw2rzIPdAsKECiC6wIao5pYYWgMzMMOWyA7vxAZ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261022075727099003)(11063799006)(261022115727099003)(261022105027099003)(38070700021)(10067099003)(261028144727099003)(4143699003)(261026140227099003)(261026130827099003)(56012099006)(261026135527099003)(261021135927099003)(261022113327099003)(261021130227099003)(261021121427099003)(261021133027099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(18002099003)(55112099003)(22082099003)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vEm4l9wXcEUgKI3451SAmRlz8cRaJmOSFVvKQfjufTEDvCz/RFuwocTNWv?=
 =?iso-8859-1?Q?vPzeCa1PI64nbqgqF1Pn5u/XdlLzKYqD7b8H7Z4LckzqLzXMz//SjgvT06?=
 =?iso-8859-1?Q?9yt9pq3SMhRg/afCGstocEROEu2/xvu09ae/XmZtM5JbAS/DYPIb8WUzEy?=
 =?iso-8859-1?Q?UbkAflL1hHtNIsMo+I39Mlgn840sBWKm2u6C+FhKCQ06o4BCYKseSwxLEE?=
 =?iso-8859-1?Q?0CM9i8xhoZPRArWxwtOiPM7EFcubNdlzWHdSvLNNEr21w2yvJGhKlW27jy?=
 =?iso-8859-1?Q?ZUdwJtYD1JM4m1HcIiCczP6mNlkOaoG6uYQ9Jspx44ZE/e6OzVRhSVCZFj?=
 =?iso-8859-1?Q?5qHrD6txkFfNk5xa4UQYCiJqIivMhtamUTC0Tkza6qZbJnMAI+XqXYMNDB?=
 =?iso-8859-1?Q?9gAwbX2pDJA6VhY8E0hq37J9phUojM+wMx8ZpRpErrbJjr2Je3d17SZi2I?=
 =?iso-8859-1?Q?FSj/sO0P0oAw9rbfAN4jIK884TsVzffLXusArqvzB6kx0Jf3nxxVWGg7AK?=
 =?iso-8859-1?Q?kcSFNBQSdLCgsOuMdz/OVdS2e8OtSNny5jQtrKc0HZcUFfbMHm7L1cx473?=
 =?iso-8859-1?Q?DNEUqqc01BZ4Qi22Z9o/IcfgtH3u7RyGVEtNB4pUxC0TCYDDu5XLmuLOVj?=
 =?iso-8859-1?Q?eb/+Uq81jlB/jAgetQZGX4+G4knK+dkuoVMviYY26pC4OUV/HiJxG4UsdQ?=
 =?iso-8859-1?Q?3Fr8LhqVMg5crjEV/9zPpQtV1NjSu74S0Dof4uOiPiuvLxbkGj7RECONXV?=
 =?iso-8859-1?Q?+am1wVu1hKOcdVqkmqcnegwWjUbOkB/VJcW8CtjMO2m14IEdXiBYyPIfzc?=
 =?iso-8859-1?Q?6Ok/HgZQdhy3bxf08o6UElsfUqeFqoQQpK407n4P7u4YUISvqMU5evYO5B?=
 =?iso-8859-1?Q?kuF9q6vqICdy/jC2r5KG/UG09TTcmTiaYpn8VmviIuOisuqAlACMuSqVfP?=
 =?iso-8859-1?Q?+2Mf6menHh4KWC0Qs1p5uS3Nad0ZlLy2cqO5UWY1n65HkNV2gRePHnlIgv?=
 =?iso-8859-1?Q?Vnbfdsi51UukiXOY0r+EIrif7W4ubxj+L2woL8fqfkaOJFP0yykMZVRpLT?=
 =?iso-8859-1?Q?daDPT74mRwbwkVElTbux5CHBwt4iHcsVTXkYrETmXTSoje70L0puZ9KgHY?=
 =?iso-8859-1?Q?wNFCyWaGXaOT+BUkR9YY3kwJ2iX7GFvLdzIOwDVhbMs9OgBbzhTT8p8ykS?=
 =?iso-8859-1?Q?FybMvmtvyCtfH1Q14vex03aOG0xTlJ5X04zcCiZqzqFDkmQiP1m6ObXT2d?=
 =?iso-8859-1?Q?EAxgeBLGB8HYZyJbWjBlmQZIfDKeWK3+v1ERi9q573JWAbpI0cXzBtWCoT?=
 =?iso-8859-1?Q?gtauobwr66xlhUDZKpEGkQVpR9lfkxKW/CugRQ0O//J+9m15ToVsbpM1sA?=
 =?iso-8859-1?Q?VeIij3f2xVQn3Bu+bZZyFNqkPxUGn9TAHsTFlAo39CE2iCNFOQhlsgq1F5?=
 =?iso-8859-1?Q?DUrq+z7BCHMrfdRh86Oci6WUgMeRX2o04QSRNhKAVwsXMW7JZdd8jBuuHW?=
 =?iso-8859-1?Q?Zwbr3d2qjDd5Xk1y8Hwx+u8kjdS2qOy/SYjwVZqSTMW0HIEjXdTQCAbrrq?=
 =?iso-8859-1?Q?gQpQMvb1d4Zqwu2NfvIcPiNDHHUpIrz7Pg5SDh6va+ejxW/8j+ABd2YbXA?=
 =?iso-8859-1?Q?4VdVUO7nXrR+wtbWHaopJNiT/n4vfQ4HoqgFSA1jRh/kbqFQSfx87csCxM?=
 =?iso-8859-1?Q?zd8hblMg/zlNUCS7bcDNRCZEjODRcOSCM0sx7y0OZhMNSZuSwsewFlgrBe?=
 =?iso-8859-1?Q?eQPZms9Mj3xgI9UWZKmnIMAiahi9WRMxqQKHJR5ZfXfMKS/Xiq6ao7CkN+?=
 =?iso-8859-1?Q?aPZW7mv7TJ7nZyIgFmFbk5rCNJ99QbY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6656.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e815f681-54bc-4eb6-e4a7-08df4c9685ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 14:55:48.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOzb3Ku9TSLbNo/UOQcG5Tm2/5bExOJ3g/vr+6fKIu/V5qdVRMlkQUUSQtPsfXi1pZd6qXcJMEl35NznUG8hxkl1HPvaVS9j/xoc/HLWyBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7991
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 27 Nov 2026 14:56:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25231

Hi,

> This was reverted with https://github.com/ilbers/isar/commit/26cd11a135ae=
9a64d99484973283c53bac203fac

Thanks for clarifying, I had missed that upstream revert!
We will update our layer to pull the newer Isar revision containing the rev=
ert instead.


Many Thanks,
Badrikesh

________________________________________
From: Moessbauer, Felix (FT RPD CPC OES-DE) <felix.moessbauer@siemens.com>
Sent: Thursday, November 26, 2026 21:38
To: Prusty, Badrikesh (FT FDS CES LX PBU 2) <badrikesh.prusty@siemens.com>;=
 cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: Kiszka, Jan (FT RPD CPC) <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy SWU_ROO=
TFS_TYPE artifact alongside swu


On Thu, 2026-11-26 at 08:23 -0500, Badrikesh Prusty via cip-dev wrote:
> In upstream Isar commit 63935232 ("image: remove unrequested
> intermediate image types"), Isar began cleaning up intermediate image
> types that are not explicitly listed in IMAGE_FSTYPES.

This commit has been reverted. By that, the patch proposed here becomes
obsolete.

Felix

>
> Previously, swupdate.inc added ${RO_ROOTFS_TYPE} to IMAGE_TYPEDEP:wic,
> but only added "swu" to IMAGE_FSTYPES. With the upstream change, the
> underlying rootfs artifact (such as .squashfs, .verity, or .erofs) was
> treated as an unrequested intermediate dependency and removed from
> DEPLOY_DIR_IMAGE once wic and swupdate completed.
>
> However, delta update generation (in delta-update.bbclass) explicitly
> expects ${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} to be present in the deploy
> directory to create binary deltas against previous release artifacts.
> Explicitly append ${SWU_ROOTFS_TYPE} to IMAGE_FSTYPES in swupdate.inc so
> the payload filesystem artifact is deployed and retained.
>
> Reference: https://github.com/ilbers/isar/commit/63935232
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-core/images/swupdate.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupd=
ate.inc
> index 699c961..bbedbdd 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -22,7 +22,7 @@ python __anonymous() {
>  include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
>
>  IMAGE_TYPEDEP:wic +=3D "${RO_ROOTFS_TYPE}"
> -IMAGE_FSTYPES:append =3D " swu"
> +IMAGE_FSTYPES:append =3D " swu ${SWU_ROOTFS_TYPE}"
>  # input is already compressed
>  SWU_COMPRESSION_TYPE =3D ""
>
> --
> 2.43.0



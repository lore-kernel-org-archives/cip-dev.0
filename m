Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58DBC27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 20:17:28 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.72])
 by mx.groups.io with SMTP id smtpd.web11.456.1719433039797801720
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 13:17:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HVnJf/T6;
 spf=pass (domain: siemens.com, ip: 40.107.21.72, mailfrom: christian.storm@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naI62BJ6oz8nZrmG5fsNbyl0RAUn8eh4EmXZmiutyRtd33CgpAbEFq5IiiG1O9Ck9wxD9wQls1zYVFNQ1v98cwk7N1r5igSa5NdKDl0Trll27aFU5zt0AtHv/rTLtLUeUJopldfulEzbGuo8Ja+LKowKxZdXp7nInIaai0B/4Dhq2qGawG20yMeut1Jn1LnqJwRkJtrowXv86Gwdef12G56o94LmLzRI9hY9BDaMvzSavAeLx7vCdfKHmOj09JZFgIntoReVfRbTtFWKLEqJhTJoxv4GTnuPn3Tt2n57OeVu2to9BTAWPDxVEaZ6T/j9iXx7wVUJiMb5V37Ef+3/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdz7IEhYL1IPtTt6HaMbGxZPauE8+c11iKdYYcbKYqk=;
 b=cBWVmL9b/pkCiJgK6t5LBWnDpvQ0GLNll6mcZoelOrT5RW54mBaB13kpZMKPRzyDtUud1GK5/jvrdKiYMDmQDo5IjA9U6ABBqTWlv0C8IbKwxGDJrmAA+J/ZIo/WzHcQjSLXzerIT2e5o2QUoJDmDiVDMTm9H8d2OOJiiW11E+SYHhIBHd1MbDMd6VKIb+gVH3k74VI4sPgMU/Z9Pph4jTxE5/DnTqJ2vgGriKTYUf0sqKE3O35MvR1/jAYlP26VnC84JvVJa9A9p4TdcduGtEb7YTVRQUepWAudrwR9qgUGve3Z2uDiK8sO3+BmVhIPA0cj2LZ+rpbvktb0hE07+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdz7IEhYL1IPtTt6HaMbGxZPauE8+c11iKdYYcbKYqk=;
 b=HVnJf/T6K6sAPLCI5JEFNikPShrB6eCiso5hzvHD+GwtNW8/M5QnpJQRU6ntnqwfoYy/p0RkCkkeiB0dwvsIyGK6U+o9hgBwXI8IoAkT7994bhy0eXdabqKlojyhSHyMZ/s/fyLnps9jLif9gD5/HnnKhGmEdE3QwBTKXgYaKe163IE/5pmqot9lBrws9mAOyIih3+56lsQ0DVorV5UjUGWGWBDhIZBJiPFLBwRVusopfhHQzVtc86xbbjuDCSDDKydah1lQ26PX5V6yRsQHfTOfgaRGPmUUyzYXZ9xQGSYQZpAj29WcGaGowElZVOoj70X30yPj9NciuOgAy5m/Wg==
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::17)
 by DU2PR10MB7678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:498::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 20:17:16 +0000
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e659:e46:3b99:a440]) by DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e659:e46:3b99:a440%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:17:16 +0000
From: "Storm, Christian" <christian.storm@siemens.com>
To: "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, "Sai.Sathujoda@toshiba-tsip.com"
	<Sai.Sathujoda@toshiba-tsip.com>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAAS1PbFAAEtUdAA==
Date: Wed, 26 Jun 2024 20:17:16 +0000
Message-ID: <6FC4E265-2F94-4144-A714-784FAC157CBD@siemens.com>
References: 
 <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
 <TYCPR01MB9669740DA683EAE4C6E8ADBFC4D62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB9669740DA683EAE4C6E8ADBFC4D62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5404:EE_|DU2PR10MB7678:EE_
x-ms-office365-filtering-correlation-id: 8c99d887-a73c-4841-5f92-08dc961cf967
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?APizLwSJmJ46UTnD91DK6ZzAFgOM7c/MAvn5h6q6NZAGSDoIf+hiUNoo39vu?=
 =?us-ascii?Q?gE/H1MjBHDcrd14xgPWqGbhADYIarrwoPpjpZ77nekZ8WxxyD2ahdRPGwt/H?=
 =?us-ascii?Q?Es4p3+1uY0E4KsOzXe7LCbSOVAp0EF5E1+fUOJgGWE+66Bo3TlaaYIGrCWdx?=
 =?us-ascii?Q?k3IV8ttX8IFbRDvB9CH7aLqLyeKj3IoOBtY8lI13WrQnB/GoI7vPgMlQ4aja?=
 =?us-ascii?Q?9iKX+pAtHt5M9d8fsloJMURH1rXRq0bJdkcIAgHATloq7Gwu9ysi6MWCr/CG?=
 =?us-ascii?Q?pXOicDWffutD340DKHl96bzDCN+/LMWuKJeyKy0kknsS1Hd+17xdwnaCHiMH?=
 =?us-ascii?Q?gds3RB2LiA6iDS1JQqp9fP/veAbPCULIjJ8zdXYQCw7zKveYH7/9KW+qM8CF?=
 =?us-ascii?Q?+Qq85keYMSvY5o0MIr0sxZUGJZxSy9mPkzvcfrmG259Rz6ozKcYhHzBk/9F1?=
 =?us-ascii?Q?iIjKXr7L7s6F+59DJCaD1DUYLTK0fKWXhNukWiY6v2kK7IEcMD+SpZBbZPyw?=
 =?us-ascii?Q?raXCNgU5Ahxs7gtgobmHudYRULWtngEsSky/sWoZNkFUZg63bgHct0y0pEMw?=
 =?us-ascii?Q?BO5Wlxn8uCBnkFSnu1YfcbEfPGiE67dzGsdaEhZlpCMu38OnmRxKCsu3kPsr?=
 =?us-ascii?Q?7fTY8GQL3nwRZ5CdIC4lM3koiyLqDaxoDbfE8hG7bogLWv/bHFUjx9pVqZT1?=
 =?us-ascii?Q?woePBl9J08Qj8Gk4tMDUyoon6CcPZH6N2/tfxAsoiFVgk9L2GVzAQTtdbWs1?=
 =?us-ascii?Q?n/gq/tkJ7Z7HlAEkXmfusmOjQiuINY+H5JEUtF6cDSYBdQNInbZ9ZpePJtCf?=
 =?us-ascii?Q?P8bNhV1zLjLRg1mxKrBbGZTvLjLR8QxjmlVDTOvjBiySKJuSKnAhLIY9cCwu?=
 =?us-ascii?Q?VbSGa1qDgTd+PqcTOAP+Apb+rJJLD15V8Nr8nE4qjNCQXvy9BmE9J0ad4TZC?=
 =?us-ascii?Q?2R96kmU6W7wsS6saP/dXcceK4nkxhIgXd7zRAWog9lDD/39M5prnLfAh+4td?=
 =?us-ascii?Q?JmDXrkCXNixx2KFABOrKREFFS2jYQr3MdaxYyo/AaHmFjGMCbWC0f167Tay6?=
 =?us-ascii?Q?YoZW4G/7Z9+JWF3L+3YWmChOm45x8ZAhKrsmHz/XPGyaPlcwR9+wyNycwmjQ?=
 =?us-ascii?Q?xCfBE5LuzevtQv+wO6/n56Evq2qLrjbqNrdHaAP3MFObPym/9Yb3/3065u7l?=
 =?us-ascii?Q?WcjDPq9m6qPWV5vY9TQ/SE5ybuUFKi8Ajlu3N9yESqX54P1qd2RDlrwdSQDy?=
 =?us-ascii?Q?78GY4ufhSVLB0x6zjYmNREEbqeRPO8vEvS2qJpO64R3Dax4jbcRmHnNGDju7?=
 =?us-ascii?Q?EX1/CcaPuJCPYg099M9HviXqzERSpMl8IogwymGg8mwChItY5FUlfKhG5OnB?=
 =?us-ascii?Q?c0Yo5W8EN54vBdcsoZ3SQQK6/LQC5Eh2YOdnqdCDGMtRh6fngQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?j9yB8m6ghIeLu665DwGr5zqPWoIfJoCehz/CketkfwT8NQ8IM4jP5dJLZ0tX?=
 =?us-ascii?Q?RWHUWIuZHNueCKABqzlxlgjtp0856NQpjS+Rm9GVvThzVpj2T5z/okSax7bd?=
 =?us-ascii?Q?+FT7UJFXUIWJJpsyjvXoyVpEF94tW0DN+eMs5l8mRP97d9Rqlp9c1UdHDDix?=
 =?us-ascii?Q?iOC2ixRDKI6dmO6c0uvmny1hJqK9yvSqwMZVGZGtFYolgTfEpjrOICwKVNOp?=
 =?us-ascii?Q?ZW9FV4ab6qiYV8D5ZfZKBqcQ515yyGnHWbpnjIG1qXOsQvJZxsypfTr9/aO6?=
 =?us-ascii?Q?V79ekhQliizm7pMCexngV+tO07KKmbR2V6LiTRT0tl9BD+zkZ5m2XGB/4B6E?=
 =?us-ascii?Q?3HUmo8Cu/BVseIIn2CBJGOxByBD/KRu3A+bwO/B8AHT6om4mWHxckfkWxQr8?=
 =?us-ascii?Q?iEyyrT9sLJqE81cSRkiM5pJ2Eg0+oltehwXFa7tVgU9r5PbzSHtUdkMnatDU?=
 =?us-ascii?Q?m0mx8EFN3btWg548YbxT9zR1AsJ+icLviK2wSLKxt4bKVwUf9/A52kuIQUiL?=
 =?us-ascii?Q?1UAXukwYH+cO4Ta4Dl4YzJawO6iWfLDpJTOV80/iGP6SDhxSQU9EGPj1ue01?=
 =?us-ascii?Q?FOcLSyH72BTDMR9D19n+bKr8/5YcLlPWYbW1OKPoda0aGLbP2GbWQ/Zc4BDe?=
 =?us-ascii?Q?DAgfLy9SOv4ccGU/qe9nYqZBoQxn7PYaZlIpROPCTwZdGQMJnQfft10ghUtk?=
 =?us-ascii?Q?32Whiz1X2NxzIgz9kEWqVh1fJeINnycbAUZuyWA60lEC4ksDY+XGUqXtI0IZ?=
 =?us-ascii?Q?vvuyL0e+xdSDrGmgsN7fgVGFpqDDqkbfQMaOOzW29BW7spJR0Sszcld1N3H0?=
 =?us-ascii?Q?9W+32NV1RXqxWY+ZMu8LdanQI4/rJmYiHs5ii0VSQDAXbHKpsY8tW81vPAgl?=
 =?us-ascii?Q?foqVV+ETZCXHfLRCmIaHBS1nEQBj1P8Px+3YMZpW7tIyzNRpPJWnmYjAup/p?=
 =?us-ascii?Q?T1YfsTI9qInFmx0JMacjLiCld8a3TGwjlRMIy3Z12PJhdZcI6EdYE7cUVXnd?=
 =?us-ascii?Q?fnl3Yeo70+AtS/EHMl25cuCsxqRF9ronGADoslVBLwXAXz0vyhH7nrs2PDX8?=
 =?us-ascii?Q?0jysa5zXf0s1xR+eVi84CM9beXintzRheuLzUY9BkBnn7knpThT7bbzxB8pO?=
 =?us-ascii?Q?EwCzXaf9rraPjLJS6P1e6RvzpFvKdR2qM649liQ9sCX/cvp83kD2n9ofN1hF?=
 =?us-ascii?Q?gX/kp05Z7wDO1nqkP4XtpFVnJg4SeCCMMexPpLID5QrCoLiVw4Sr3krWHfjU?=
 =?us-ascii?Q?5QhuD3Ztez3p6z/CrI9A7mumWFWmRo6ukzRyxhMn5xmCU6bqqSqpyVOWxbJU?=
 =?us-ascii?Q?/bIMMcjkKiaFDvFnzO95sEMQBbBpLW+nsbIMYRxOqr0T1aI1Y0xiqsWvlgUZ?=
 =?us-ascii?Q?KdXs//BvoKCq2EVXZk1N+OmALLf+iLJdvI9XQ0/ZeEDMngFWdrIZm3K6QTaR?=
 =?us-ascii?Q?AZ7siFLAjM87O+/xn6w+hpNe44r1UfG+ogxC9o0tpP9zXgnjtGSRAvuvIyxV?=
 =?us-ascii?Q?1UmMIm92qTQ/StUl/MagDFd35nPpIFpR01OibgLvSpoW5eguSWWOma3cVG+8?=
 =?us-ascii?Q?+QL8vVtTH+E2uMmenqaMkVjGzrWMzKznZT148BgSDnBAyW92pk+xzU/VRZIQ?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4975C58C9506364E91021EA0943CF17B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c99d887-a73c-4841-5f92-08dc961cf967
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 20:17:16.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sTxzazpY3TeOsALupRELnPPBmz6V+0tiIN3JArCpsbwIwbWUEc2ov4UwBPi7V+ewYn2DkAmLZUihiCbWFKiEc5UVSqkBCLyWea8C1w6r3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7678
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 20:17:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16334

Hi,

> The mandatory configs that are required are the wfx server (backend) URL =
and the client-id. As per your suggestion, for the backend URL, providing a=
 kconfig variable so that users could enter that value before the build see=
ms a like good approach.

This would be the hardwired default for the upstream wfx server [see below]=
.


> However, Currently I am not clear about setting the client-id. The client=
-id is required by wfx while creating the jobs for the specific clients and=
 also to monitor the status of each client device (like update status etc.)

Yes.


> Setting a client-id also via a kconfig variable would mean be to build a =
new image for every new client-id which doesn't seem like a reasonable solu=
tion for production.

Exactly.


> I am not very familiar with how such device registration / identification=
 requirements are handled in a production environment. Do you have any poin=
ters in this regard?

Usually, you have engraved in the "golden image" sane defaults that you wou=
ld want to roll-out to all your devices. Then, individualizing the device i=
s done by onboarding it to some device management backend. While this proce=
ss, the device gets an ID and is henceforth known to the device management.=
 Also while this process, you can do further things that are device-specifi=
c, i.e., configuring SWUpdate to use an individual client-id for wfx. Note =
that there are many ways of how to actually onboard a device but the princi=
ple remains.


Kind regards,
  Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3, 85748 Garching, Germany



Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F124DC71135
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 00:23:20 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.68])
 by mx.groups.io with SMTP id smtpd.web11.6115.1749674812732021162
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 13:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ejlyiGhY;
 spf=pass (domain: siemens.com, ip: 52.101.71.68, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oliX0iwS94g8gKl0qgZIBSi8Un1UU1KahcEH3sixHzXGP8G+W1+MVDw8Mn8kQU+NmDUqXelAw3K8ItldLTol2ljGKiWrhfw1recMUyYCU5wFH5d1N+5eMEcw0o4SMrJl79sO+Qo3AR+KmrvnZ9uSMT/MjvJllTtWVmg1FZOJNdxlxCWguj4mFr0bz1Ri2o1zLUsZYxXb2C81pZRnZe6w7JYUbiiNsU80/q0rY741oHL/Ucn+9uP52lBviADpNvPnSWywIWuyxeNdQOPOcIua6DGU0ZBq0GP5K7TVnkyigDIHmJZDro3/RLYHAGbt0uHc6yRwIfdhkzHJq2GjLvaKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw6F9Ve70NYRMfBGc1GpjF7uugouNYqVCLzs0Qr3P8o=;
 b=oLHrYCpzaGpqTYBrQP3LAKfO7xwh6KfYGFU/CH6miON0z+ZT57lcpBQ1QvnbLl030qcrVqStsiEml6WDJcdjOFcvIqbLBuWSy+GD8DM9DtDM7cBTUwUCWsI0L+MbCxprYbCEls1MHiLc937mNHDkZNZPbCbiOhflEQ59E97TYdzxVd+lKoEjhX/ObJJJ7ps1YBKi7muRWKBxXiiMSWlkBeDPVM7+Bt61t7aKEdM18G5YWsEXKN2/zdMtwwYfEiS1N7N7iWZYGp/nBBBgRnMlnjQCipz7jSRQvUr0iZXwMgp61ez9NuH+nY3f7BNlU2HGWLwOdt7irv/qRxRE6xPAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw6F9Ve70NYRMfBGc1GpjF7uugouNYqVCLzs0Qr3P8o=;
 b=ejlyiGhY0U0cvRLZfmifrdUqQP7NNjMYUXbNOuOSbnHmCO2QOx+Fy4kzaT1c3wb8LU7Q9D+b7adhw2LKieEdvCedRovwqu00YVLPeOMDG1uw8fh02lyXtogylTcuIJSgmNxZOdizBGVryYYzAbY90bpSw3a2CklJpkItgjhy4VzSDsT7lANWHxolfAsRv+PDRPeFXl5H6bWDlmkF5a5oR0qH94MCOWzkJvegRWlYhXT7YEVq6tpYEZtXLEh9Kulryg7aN3WaIYXAmXEUyt6UA28qWDj5D9KgFqrZM6RH8iY+qqctFVsB9nxqSV70eLtvKDWtju4CaC9TkpVsTRcaqg==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by DU0PR10MB5605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 20:46:46 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 20:46:45 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Claudius Heine <ch@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Heinisch,
 Alexander" <alexander.heinisch@siemens.com>
Subject: Re: [PATCH v6 0/4] initramfs-crypt-hook patch
Thread-Topic: [PATCH v6 0/4] initramfs-crypt-hook patch
Thread-Index: AQHb0W3Z1EgfPBWCLU+eSDzvsYtruLPvi3CAgAABVgCADvAhYA==
Date: Wed, 11 Jun 2025 20:46:45 +0000
Message-ID: 
 <PRAPR10MB542211966641957AF9AD3C788075A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
 <69ab7fad-b2e4-4fe7-bb16-1d6e0bbb4d5a@siemens.com>
 <DABWFSN87AVE.H2RGOY175Z6S@denx.de>
 <a22f282c-efea-4cfd-9870-118e1950b828@siemens.com>
In-Reply-To: <a22f282c-efea-4cfd-9870-118e1950b828@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=bbfd808f-46c5-4369-af78-38b09e01ad97;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-06-11T20:31:59Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|DU0PR10MB5605:EE_
x-ms-office365-filtering-correlation-id: 2f829aee-9313-4c62-f516-08dda9291462
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?X4LuuDEYXQ1tuTw0d5yAgysfiLc1znqRxQ04WVUlTCcYV3q2rY3/lBMLiZ?=
 =?iso-8859-1?Q?c0+IJu6EvFHnxk+q1t2imqQxLDwhyp/+G0KMNIiycB6Aoo3Q+p4tjHbomj?=
 =?iso-8859-1?Q?EQWcN9aQXft/8L0PoSGCkQ7zNcWsJq5wY3irrh7lZmJFnjuMuBtcmEJyNC?=
 =?iso-8859-1?Q?KjoMBeHE8aKfnGcvqfM99OwUCrQW+W5oEGwwGI/szP9sksdhiBF7EBHQmF?=
 =?iso-8859-1?Q?OscfaLHmxWXJBGVw942x58PWH3okarhT1ZkO4rfp+cRj85VmmyzXAUDueu?=
 =?iso-8859-1?Q?+aNAhyryxuSveXC9lICsiNL9ZKzqfSxBKaEg7nDsuOzcWlpLTnBzPZlwYw?=
 =?iso-8859-1?Q?vHUl+wcgBPQBUi+KLca6NrFjJ2xSpw4mefRCmRoHbOQ4gIsFNs+UbjTOdK?=
 =?iso-8859-1?Q?4EAVJOV/R4xacdS+9Ia3XSO44VveD61suBBt0SlaqGEkFsAW5LhaVZ0c40?=
 =?iso-8859-1?Q?q6iKrwfNkdzTa0jHlGaJmZ7kiZ/NYvGYJ6Rl7wLvexlhjigcmx0Z83pyC2?=
 =?iso-8859-1?Q?JQ0sfj6ImIzRsqBHiPcCUuJXCbFyxV/tO7fmKUIHzWSmtBWhBBXyCqMvK9?=
 =?iso-8859-1?Q?C5OVtiX2vPP+R9MJichmcijmXZfZlIo1SAutuBVhuwcM3vMqq3apsJI6gc?=
 =?iso-8859-1?Q?8gu9iAUMCue43cVN1vpmyAYIF/6Mw5IkwgBa/O9NZVwYtFkFz4kwdj+0GL?=
 =?iso-8859-1?Q?F5TynqSbCduTxtkkQRHHbflpQYB47Sd9UpVl+u/QfmSlJb1/YkHtCU/cJj?=
 =?iso-8859-1?Q?ggk9cKs0MCd7L4Py3IYaTneD+7op3PnAyKtMh13i6gx/aM4a+0y8Fp1WiP?=
 =?iso-8859-1?Q?mAiKEcOGQXnE7Dad9O5af4VRIPMyswCvgWLlKYSRX4MMMfEusUOeL2V4IJ?=
 =?iso-8859-1?Q?JlI8gihpu702mSwqGrUhpFv8krwxvzFRZS4gVe3Bg4J4mT62RJl71UlceX?=
 =?iso-8859-1?Q?LFy+RjkmsCfvvwsR/iBfuBqbIwzN6j12A79KORFQ7yFymcaWzCs9nxJVML?=
 =?iso-8859-1?Q?4vncO4Qvl50vuU22tO6d7ybKGfn3P2zG8BosSfWhiswGNrAtn6+jyRCXUU?=
 =?iso-8859-1?Q?qu08m6n3ihkMFwxUohoQsQvg3kiUzEfuY/Rumn3vfAzFwW8pOtGJtvDHLF?=
 =?iso-8859-1?Q?ODNgDXYNy6i7qzFqSBBnizU7FjO2N/24YNSNFebxMYjsWK3K9cRhbiV08M?=
 =?iso-8859-1?Q?btNwxYOvNDK1HtnbTLy3SeaiEe2ZpBqdhMQN8CSiBn/RgJrAPPBAggcUN6?=
 =?iso-8859-1?Q?Dh7W2PIT2QuqhS+HxXcRBqtoLD3fYLkmzu+YKCGFJjPDxf8O7OruMUjSKe?=
 =?iso-8859-1?Q?xqLDlFXxAUYm0Ije2DzknpiG6kjUrPOWdpH0HWrpiCntul2tahVUYyurxx?=
 =?iso-8859-1?Q?cUX44YEROvFiZaSbcYFppbvMgas8/N67m5GFKceI+dJhgtjJ/UMfosSupV?=
 =?iso-8859-1?Q?H6fyCyVV+qU7yVfATLxPkSFOqD3zzZIFAbQlUjRJYES6d6mCEQajLOSf3D?=
 =?iso-8859-1?Q?aJ+PVTcAdOGsOWOEuCL2Nf9ZqMpFUGweCjxuO8Gna6MyZgGwINCZS1yG27?=
 =?iso-8859-1?Q?pJ8HCNk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?YRufcygOKiGrILvBLX9BQPN7jEMuLr/o3D2uLsgnx2Lsp8LkctADrLJiqT?=
 =?iso-8859-1?Q?zFhiJiRN+K6TQIsiL7IqFG/XbLeeuSZhL7n1cVNX4lJ/jpbulbCFzrP1bo?=
 =?iso-8859-1?Q?y0yN5P+WFXCNGE/UsGn+xyjjiUbyVlmnGyV9jcl+zHArtMT7RNOYngdk5Q?=
 =?iso-8859-1?Q?4cUEN/GVs559nh4LCUjH7ADqiEv7ltv5R3A214tsLjn+SBKa9CKAUuAalF?=
 =?iso-8859-1?Q?VMkMR2O7WSWhjDNIBfMOHtKwRhSECJN9bYSn38YVUujxRvinRpz7eOcEa+?=
 =?iso-8859-1?Q?bX16wZpadtykCsp1F+cDWW98nFKv7njEYCWWNlcLTt7cQv9xLTXVKvt/6j?=
 =?iso-8859-1?Q?bv/wBwI4rhWKSbyhVWr6cw5gfUbOBeUPom3br/TRY1QVD4pj0yGIYqnWvr?=
 =?iso-8859-1?Q?b8s+0AWtqCY1b3cg8qQhZSziq7OUoTOebSLDt00PgLllsk25aiBw9dmgnf?=
 =?iso-8859-1?Q?a17JVjpz1vaJ4iI62wnsErx5+9YMBGUnKJWlGvmpIyzvNlx8O/TRjlva2j?=
 =?iso-8859-1?Q?V77U491X8YJgcS8Xqy+F0L7woWwVehkVhaFlyoDi50Dk15TsLR+cMmI7mb?=
 =?iso-8859-1?Q?LlfnT0OiVy5uTqqDrRXF4YV9bAhrLV1KgpkMwSDZ7RJFleWDnhLQJZOW6U?=
 =?iso-8859-1?Q?LLzijOZHdNmuBTyhv9cr7KBk4cP66EDBmamLSnHhlj57yxrubTXVoEoaNj?=
 =?iso-8859-1?Q?3zWW5Oxm7hLzh31BQBWN9IxtBoznWtgk184A8S4QpV4qFeyAigbTxxIz+J?=
 =?iso-8859-1?Q?8eprjoWYS+avGqmkY1NCxAgvtVjMqzvrsO3HAE2mG7kbyfmYEbdQNo17iP?=
 =?iso-8859-1?Q?niEbR+NtOJF7/bAzkgHzyQWyQwm627eRAcUBTEDf8evWW5agJ66izyWujH?=
 =?iso-8859-1?Q?5FKR9sbSilp9v+Yd4GY1VAj6VPqfxShXgBZm3wau1Pybuae80kKDNRAXm4?=
 =?iso-8859-1?Q?LjYH7xP/xrWcjrgBtteLjZHlWS6CdsQDhmZPFFt+GvYfqzNNE4Uy/T/Fny?=
 =?iso-8859-1?Q?ay1mE9+qj1ns7bbFbuVt2VpbnOVaX8gp2lJ5qRZAeVQvVCdaSMDLjL5Ugp?=
 =?iso-8859-1?Q?hiGk8tMbDGuuW/XQNTOHeYdz6r6q3fhpFWGm2FA0gHjPC65dK85XhuY9vB?=
 =?iso-8859-1?Q?BtJDi2otFCccIYrTzceiY5egYuQW2qioaN2eu5Ivd5zy8SdhzMmVg3FcAZ?=
 =?iso-8859-1?Q?iKr+7iWyj0mM7ylk8I0P7e6+v0dA+8dMdLnC0lP/Q5Jxlimu6gVuqwsnt8?=
 =?iso-8859-1?Q?yNDxm6dAihgSpEHV+kLpiSy/KBzuBNWU4pWgu8tgHo+cD8tJyw2K7jcjlq?=
 =?iso-8859-1?Q?5HlmNK9X3LG1IgfeszpwGml/hay+DyKD14XtGgWc7WWpOXh4KdHzb/HGQK?=
 =?iso-8859-1?Q?Ffwwhc5rz3tuuXs6ArKz8OLgpjJkav9rqLGi1gW+MSQ1Pa/0igoL5LotKr?=
 =?iso-8859-1?Q?krkEpLERP0K/W7uamr43AWrdrNRpe56txtgKAA2Q9+MgOlnUmho7TNCb7b?=
 =?iso-8859-1?Q?0TZ9nCrN5o2J8W7a8m9HszvKWisRnv0ArqNixiYodUTUXL5yvTbYpC/848?=
 =?iso-8859-1?Q?UFtPk0kyAXNaGV1wM/8aMoQZROltm6nZnvVvzqa6LyX8mec5pxD13TgrO3?=
 =?iso-8859-1?Q?PTEluzFyCNwzFTGcsouqqJhzIlvaXZPDN3?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f829aee-9313-4c62-f516-08dda9291462
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 20:46:45.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uENJ6ykT+zrkHEuuu/rDsAxvX61fcx8SXvLkq0v7sY+ae88FhyE10uhRAxCGubNrRrDQenxESEn+lIn2qe6JTDRLa0fALu91SYs1slsgXJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5605
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jun 2025 00:23:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19036

Hi,

One feedback from my side:
`tpm2_createpolicy` is still used by the `clevis` backend and should be par=
t of the HOOK_COPY_EXECS, that patch 1/4 removes it.
Probably overlooked because it has no direct use in the encrypt_partition s=
cript.

Regards,
Gokhan


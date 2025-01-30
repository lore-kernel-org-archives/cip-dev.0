Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A018CC0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 08:43:08 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.30])
 by mx.groups.io with SMTP id smtpd.web10.10932.1738222862391149078
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 23:41:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lz1sBzRR;
 spf=pass (domain: siemens.com, ip: 52.101.67.30, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLi24ShWzhZhu0gEwDqgXCS3dT0d2YnUWaXfOhmUWxLEHUI8vhJ17e/acZwXR1cqm/cPiGa9G4fdpO9BDKV/eWWKr7ughSyFq25trHrLA3nV7I8ZBpQQkZNxJs8gxOtkDPUauIncu3j8z4K/6TV8GZBvIdJmjC24rr/dlxb6rKAB75NdTkoyI/uXXDWVbmcm+AaZxoJtf6iQyjyBw9js+htkG+63Jwn75J80ipYhvEKNQ5JgD0eohrBI2eHbkpi+17Ym7wyQPOTM9DrJAh/3ToY74/Ck5x4AvHVqunnV+yR8dn6jnb6y9WG8ozbWrxjTorVpBr4S41Mbcg97RqIb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF80kBHBoA9bpOoWDHZccKjv5MttILtFb2TWZG2fnbs=;
 b=FdRx56P9n4yHnEy/RgSBcbrHsv7dr4kmTJFYJOcGuDK8ZmFI/Kw/yo7ZDsCddeG+xT6FMaiw9x+nM6rSVWaZU0si0+dJ6S9osFQ9xrdv8XvGp89XJajRLjVDphnee2W8nOhLFdep5bKbajhu29q2BTi9MgqRES7cLi96YlsISLFLylxaweppuVhFoEBZB378xQBjetTQxSB7LDukQYoKtqQgcukjf5368OFtt/Rq8olJnEBdDOL4cbryeLjNUyFN1YfGbY6YjcbfYVTe5xn45Y2eNjw6CeKBIv9sgyjlC4/JY+WpZy4OQqllo0pciVt7GhrSeHL6sKUU4eM715J8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF80kBHBoA9bpOoWDHZccKjv5MttILtFb2TWZG2fnbs=;
 b=lz1sBzRRW6oPAmtDfWsgSaZiez3BWmgdB5B8rqwAdSK7jAYVWDSzREz+Ix7mNcCHNtRW/ARaaYdooXwHjYHX7TV+uAGHvI+9yO4v9TtMZnxG/F2TCLUgJKgHmpL+UMETB0kq8nHn126hyHBv/roGHhaP0SAit0I8DJOTzBxGwqO/RzQmUlvKFVVihn6I6BZIz9ZN2tT5GN0M2C/5N4w3z9UgnujSUWFqbLmpB71sJGxz7/9ppT8x/UP6tQRSdIclvq1yhX+tSe5oReaXhLyRUWuElCVAzmIdVY0l+ntyKfB2A4xU71lJ6YXG9AqjAWXz3daWKLrleQrY2lPJAt8PEw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AM9PR10MB4037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 07:40:59 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 07:40:59 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Nussel,
 Ludwig" <ludwig.nussel@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC] read-only-rootfs.bbclass: Exclude var and home from the erofs and squashfs
Thread-Topic: [cip-dev][isar-cip-core][RFC] read-only-rootfs.bbclass: Exclude
 var and home from the erofs and squashfs
Thread-Index: AQHbckjvaxIC9r+v2ki0zwadMQRQArMu71uAgAAArQA=
Date: Thu, 30 Jan 2025 07:40:59 +0000
Message-ID: <d805038bed08fc2ba487d07233fd8ef999f8f8d3.camel@siemens.com>
References: <20250127140814.762632-1-Quirin.Gylstorff@siemens.com>
	 <2fa58c7fef5275ce610cfcd6d4a936793b72f3b7.camel@siemens.com>
	 <4de84093-2ac9-4953-b1a2-f57e893ecade@siemens.com>
In-Reply-To: <4de84093-2ac9-4953-b1a2-f57e893ecade@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AM9PR10MB4037:EE_
x-ms-office365-filtering-correlation-id: a5087ed0-7727-4713-5cdc-08dd41017080
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U245bWNTM2M3Ry9zTE56bWdKa2J1TVlIYVcwMnp1ZlZVV0lhb0JGTFlYa3lC?=
 =?utf-8?B?aStxcW9uQ1lmc0NxeE1GOUxtL1ZMdGU2WTdnYXRudlEvblBkV0l2S1BhL2JM?=
 =?utf-8?B?aHVicjN1RjUrUFpGeHBwUGJYUmd6L1dDQm9TWUtPSkg0QzMwMk5FcXhDYTJx?=
 =?utf-8?B?NGN5Nmg0djZQNyt6TWJxSG1DYnRDVUUvQ2NUTEdOS1FUYUhQREJZbVFIRTRN?=
 =?utf-8?B?ZGFBNzYzdzJ3dWRDSFk2OWx4MzZoZkx5RWtHWXdzLzZzNklabjJxOVgwT1Vh?=
 =?utf-8?B?VUJxclhXRkpSQUlhem1PeTZPN0ZaNUlJYXFadzNpMU82UU4vc0l5MUpEVE9w?=
 =?utf-8?B?bXR1UzVzNlhaNUc1Wk1NM2VxdWx1bGNoZ2VDQ0p2S2pZcTZVS3NmaGpERXBa?=
 =?utf-8?B?akovVDJQMk1xaEtZRjJaeVhVM0lIczRHb3ZGK3dZdGV6QUxqNmhBcWxDQyt0?=
 =?utf-8?B?d0FOSnA1bDc5WWVKbDduTFhhQ2t5TmZwRm85WEdhUEx1U3hCN0ZnM21WSGtn?=
 =?utf-8?B?ZW10N1oySW54RG9hbUYzUnBhUm5iTXdBSU5FUkx2bThRdnBkNjNlMWZBcC9W?=
 =?utf-8?B?VnQyTnZvdjdjMlZ1MXJGMmNIRitSM3VHOHFvbEQ2d1IvV0hMaGQxT1ludXBX?=
 =?utf-8?B?dTRHclgxVGMzSVZSd05SdlByVnRodUp0NS9ic1QwQWRqT09pRWRIcVl4bFk1?=
 =?utf-8?B?ZjZIYWc4VWVmeWk3RURyOEUyT0NJRW1CQ0JIckliWnBtajBtV0NxemN0OS9j?=
 =?utf-8?B?UmJZZGJEUC9YY1h6a09zQmgwT2M3UXk0R2tIUHZBSFEwdmx6OEFzL1cvZ2tW?=
 =?utf-8?B?Y3N5N0NLTmRnb2xCUWZyRzN0WVBaTG5vYlppc1FXVVZqRlNxdkZ6NTdwalVY?=
 =?utf-8?B?Tnlyb2JwbWNPaE11dTlkRFpkbERxTk9HdGVtQ0NqL254NngrdDdRUlV1b3c1?=
 =?utf-8?B?MTBuRyt3Nk0vdGRFbXdWY21URFpZTXpJSWhyTGUzSzAvU1EwQmxMOTFwTzFr?=
 =?utf-8?B?R29LaStmN3JmWEl4VEZMRE0yYVprZGRMYUZ6L1Ezc0xscGEvWVY3OGdoaWhp?=
 =?utf-8?B?SUJwYWlEaEYvNzRoRzhMSFZnandMbnp5S1hYNlNZbERZM2d2ZGtkakVnVkFu?=
 =?utf-8?B?WTVnd1JKYWNnTFV6Z3FLanNTN0dFWUdIcWFidVZOQXFHbVdIN0FJNDREZXpo?=
 =?utf-8?B?U21FVjZTQlRyOFBNU2t0QVhxVHpBRnlpQU9TaTBYMnZNekVycEhSNE03bWx4?=
 =?utf-8?B?R2VzNUU3cGRZeXkrdnRGYU96WE1rUHFuSkdESTE4SFFLV2l0STZzK1hMRzlG?=
 =?utf-8?B?U0hUeVhxZkx2TFN5ZThUS0N0YVRnVHhYZC82eWxNa2FnQXhmcXJaUGJLTmdt?=
 =?utf-8?B?dmc2dENTTmMwemhUTStmZU53enVBQXhMNFdrU214UEtSSGFidmJ5RUVQOTgw?=
 =?utf-8?B?NnRBQzNJcENiQzdNZmtwZUY0V0w3MHdDUGdOWENRQUpCRmtUbzk4Lzl3OU5S?=
 =?utf-8?B?SHJnQXM3Q0lSdU14eG04QlgvQkdFNndTQVRidVMwUGxGZm1jMkxXVHZ6NnVG?=
 =?utf-8?B?NVZudGpuYVNRMmFSVEQyeGwxRzNUeGlqUHJhRnlKcTVZZ082UFFOcGNUSHhz?=
 =?utf-8?B?dlFDUkFwME5XMWI4SmlnbVMwTkFlbVp3ejBaYngvMTJDd1VpWFhDenhVNzdW?=
 =?utf-8?B?RTNleFlhK1g1cHlNODVqMUpnTXpKbE9GSkNPbVEvRDNkd21xOHpVaVRqZll2?=
 =?utf-8?B?MzFkR2Y4blJPMk43OHlWMzRqb1ExK2JHblIvZy9IdFc1QVoweU9TS1NzNjlL?=
 =?utf-8?B?Ui9EZEx4MVpzWUt4aW5hSHkzeDlLWHNxanJpbnhuVW9JRmtzR2tSYVZKOVlh?=
 =?utf-8?B?RWdrMDBnSGNUUWlzZWtxZjRPOGRud1BEUzRJbTJMM3JCUzVsNFYxYlViWWVl?=
 =?utf-8?Q?D3BAgeSiyxshV7nKHL6qGxUuhKPziII0?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?alR1OHNmV2E1aWtiV0pIYmRLcE14dWFwMjFveWZkcFV5ejE5WkQwcWxVTE9P?=
 =?utf-8?B?dFVWOFA5TWlXQ2pZUWI5WkQwWGY5SkkrWElBb2ZXQXhWeEc0SlBjYUNsaE9T?=
 =?utf-8?B?emdtYnYxbVUvNUhRelRqRDQyQVFiMUVIcDVndk1ZYnd1cmswTEtlQjVrSTVr?=
 =?utf-8?B?Wm80SHVRQ0RGZFd2MElGRUtmSE02MVhwVUFPdTNRQkM5ZGZRdWt4VkNpbTZK?=
 =?utf-8?B?Ni9tS0JyUHZqUnc4dXNOeXA1dHV6bnF3V0dWTk41SHRuRy9mTUZkTU1CUitt?=
 =?utf-8?B?L2lOTisyakhXcWoyRWNWcUI4TzhUUXN1aFVqVHhnYjR0aTlXV21MSVYwcm5V?=
 =?utf-8?B?bnNBWWtMS0JBbzJNSVNvNWFpVnlTSzdLZVR6dm5jNDVnVWZqcGt5eStjV0JP?=
 =?utf-8?B?eFgrVy9PYzhQZ1BWTzl6Vm9zd1FEZWdoS29QUmlZQk1DQ2RUN1ZtSk5HRjJU?=
 =?utf-8?B?Wll3dGVuQXN1UjlnUXRCdVExTXEwdmdPUFZJRVZFVUo0eFNoOE1pZHNHcGZa?=
 =?utf-8?B?OFdjOEdWSExGTGRaK0xBWDRtTkJJQk1lU2tiM1pXeVRGemYvQ3FDNmRqUkRj?=
 =?utf-8?B?ODEwT1UzdFk1b1ZaRndnRXN2SGNxM3lFSnB0eFpiQ0JBRFlPYXBtK1JxVUFs?=
 =?utf-8?B?d3dZOE1JVVpza2FXZ3pncjBSbDI0Q3NXQTdEZTJDZ1JhaGtqelprcnM0N0NK?=
 =?utf-8?B?SWNmbUtrMVZpWEtXT25HcWZEU2RSR3l6YUowd3pFcVdDckhIREtyK1Jad2V1?=
 =?utf-8?B?TGNYbmtNdlFZbjFyVURwYndvOEZpcTBaTmxPUE4rTjQ5SFpVRHpZd09sY2cz?=
 =?utf-8?B?SzUxUXBuVGY0VkpTMDhmdWtnYTZ4SWY3Yk5lUnhSRDJOL2FpRHRqVFZVRlFN?=
 =?utf-8?B?QTBMM2l5R1dLWnNadmJzMnFuNkQ4cHEvTldxTm5xeVFhYUIvam9MMlNmNG1z?=
 =?utf-8?B?UGhyblk1TStVejdpV2ZTTUdXTFVSWW9Qbk5rc3JiQ2NiSDhDRE1kTk9iTG14?=
 =?utf-8?B?NW9zbWt6K0RmTXBGUzhmT1hYK3JKRmlHREtnalVzS3BGOU5vTTJJNUZTdUJF?=
 =?utf-8?B?SjFKV1paa2dISXdrK0ZTdWFXQ2k3NkpPOERPbGpYU0U1TytjSGZnb0ltUnhz?=
 =?utf-8?B?QTVZZy9nSGt6VFhWQWJmTzlFRUJuR3VsQTBFdFFIVzFVZDcyMEJTdmttbXFu?=
 =?utf-8?B?YXo3MWYrbVpDQ1RiR2xIazZGZGkwYXc2ZUxEbnRNVStUWFBrQzdac0xVcGVX?=
 =?utf-8?B?N01oZkQzNTFCaEdsMUh1d0tDRFY1Nkl6dUkxMVpRR1g0V0RTeVQ4YkY5RjZB?=
 =?utf-8?B?ZFp3YUQ0d1RUQ09LUVhHc2JXWkRMdHc2NUJtcHFIMlhtZXk2c3NacmpqdmxB?=
 =?utf-8?B?ZlVHQVByQk54WTY4K2paZzlWeEtvMnJvaXVHeXU4ZWRvQlJVYy90ZnVkOXhO?=
 =?utf-8?B?dkNJL09NZWNueDdXNU10ZzFEeitUOGl1TDZUWGRBSmtWd3NnaXNreENia3Nn?=
 =?utf-8?B?YnZIVDU4UTlTL3hadUw5Vk1hUXdnZ3hZb3JMUlFRVlUyOGVyY0pTajA0RU5I?=
 =?utf-8?B?czZqL1FoY0VjaWxCVzhJL0MxeEZZY0ljZDhLbzFzZGFOSHV2ZG8vTXkxaVlU?=
 =?utf-8?B?NTdqL2RKOEN5YUNiVS9PLzUrQWJVd2R3MDdPdVY0NXlnN3JFeDUyOWNLL0Zx?=
 =?utf-8?B?NjdsLzBiWWtLY213QklFOWlHektQbUc1TDRPRFlJNFZWZTg2MnNiVStzSXhP?=
 =?utf-8?B?NmtUait1M2I3MmZxT2ZMVlBGcmxmdElpc2tDbUNKdVFtbVU0RFlUZmtyQXJH?=
 =?utf-8?B?WEM0d3g2ZnZHY2p0cnRGWXNtbis5L0cyWjVtRlB4L3MrTksxT1o4blNWcE94?=
 =?utf-8?B?K0FadWl4NkpGb3dIZXB6MUJ0dE9mdlk1OGdXaTZLR2xYd2FDTW5VQWJJSWlD?=
 =?utf-8?B?aXFuS1M4eXRKUXBpZ3J1TWg2bW5rNkJXYzVaSEhxR284ak9Ba1dTc3k4VFlL?=
 =?utf-8?B?emdpWUx4N1RkSVpVTTh6MzJKRmJFQlhTVGJzaE9YNnAxZFJOY09PZERSenl3?=
 =?utf-8?B?Wk0xaW54Y3F0V3NvZWxuN3JHQmk1RnVLOWhTeVpBSjFRaUF2THZ5QWhCQkxw?=
 =?utf-8?B?dnZTUFhEcUI1K3RMaklzWW14ejRsOXhERkF5aW9tYW1qaHMwYk5ybjhja2J5?=
 =?utf-8?B?SzdZUzg5OFhPSVp0Zkh0RDAzbzFpNUpicWpxYVRBUi95VEZETXphdG40SUJK?=
 =?utf-8?Q?SWqwo3Ajv7JR0gC4NMSuGynH3OXXIqmf18X9R2UUks=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a5087ed0-7727-4713-5cdc-08dd41017080
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 07:40:59.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yK3wQe/CPCkX6GM1QdNOw/RQdbGNgRtPaywjbN5Oju+pdzzd/PWAA8tr9VwOVE/u3yN28y+S7KjX+ciABqrtnc0N46sGUX3NPQ2MTKMlCZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4037
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <56C46033A5A79248A6E850E6912C4C9D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 08:43:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17688

T24gVGh1LCAyMDI1LTAxLTMwIGF0IDA4OjM4ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDEvMjkvMjUgMTM6MjUsIE1vZXNzYmF1ZXIsIEZlbGl4IChGVCBSUEQg
Q0VEIE9FUy1ERSkgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDI1LTAxLTI3IGF0IDE1OjA3ICswMTAw
LCBRdWlyaW4gR3lsc3RvcmZmIHdyb3RlOg0KPiA+ID4gRnJvbTogUXVpcmluIEd5bHN0b3JmZiA8
cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPiA+IA0KPiA+ID4gVGhpcyBleGNsdWRl
cyB0aGUgY29udGVudCBvZiBib3RoIHZhciBhbmQgaG9tZSBmcm9tIHRoZSByb290IGZpbGUNCj4g
PiA+IHN5c3RlbS4NCj4gPiA+IA0KPiA+ID4gVGhpcyBmaXhlcyBpc3N1ZSAjMTI2Lg0KPiA+ID4g
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZm
QHNpZW1lbnMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoMKgY2xhc3Nlcy9yZWFkLW9ubHktcm9v
dGZzLmJiY2xhc3MgfCA0ICsrKysNCj4gPiA+IMKgwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9jbGFzc2VzL3JlYWQtb25seS1yb290
ZnMuYmJjbGFzcyBiL2NsYXNzZXMvcmVhZC0NCj4gPiA+IG9ubHktDQo+ID4gPiByb290ZnMuYmJj
bGFzcw0KPiA+ID4gaW5kZXggOWViY2FkYy4uYjNiYWIzMiAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ns
YXNzZXMvcmVhZC1vbmx5LXJvb3Rmcy5iYmNsYXNzDQo+ID4gPiArKysgYi9jbGFzc2VzL3JlYWQt
b25seS1yb290ZnMuYmJjbGFzcw0KPiA+ID4gQEAgLTM0LDYgKzM0LDEwIEBAIGNvcHlfZHBrZ19z
dGF0ZSgpIHsNCj4gPiA+IMKgwqDCoMKgwqAgc3VkbyBjcCAtYSAke1JPT1RGU0RJUn0vdmFyL2xp
Yi9kcGtnICIkSU1NVVRBQkxFX1ZBUl9MSUIvIg0KPiA+ID4gwqDCoH0NCj4gPiA+IMKgIA0KPiA+
ID4gK1JPX1JPT1RGU19FWENMVURFX0RJUlMgPSAidmFyIGhvbWUiDQo+ID4gPiArRVJPRlNfRVhD
TFVERV9ESVJTID0gIiR7Uk9fUk9PVEZTX0VYQ0xVREVfRElSU30iDQo+ID4gPiArU1FVQVNIRlNf
RVhDTFVERV9ESVJTID0gIiR7Uk9fUk9PVEZTX0VYQ0xVREVfRElSU30iDQo+ID4gDQo+ID4gSGks
DQo+ID4gDQo+ID4gd2Ugc2hvdWxkIGFsc28gZXhjbHVkZSBib290LCBidXQgSSdtIHVuc3VyZSB3
aHkgdGhpcyBpcyBkb25lIGluIHRoZQ0KPiA+IHJlYWQtb25seS1yb290ZnMgY2xhc3M/IFlvdSBj
YW4gKnZlcnktd2VsbCogaGF2ZSBhIHJvIHJvb3RmcyB0aGF0DQo+ID4gaW5jbHVkZXMgYSBob21l
IHRoYXQgaXMgb3Zlci1tb3VudGVkIHdpdGggYW4gb3ZlcmxheS4NCj4gPiANCj4gVGhlIHZhci9i
b290IGV4Y2x1c2lvbiBzaG91bGQgYmUgcGFydCBvZiB0aGUgcmVhZC1vbmx5LXJvb3RmcyBjbGFz
cw0KPiBhcyB3ZSBhbHJlYWR5IHJlcXVpcmUgYW4gZW1wdHkgdmFyIHdpdGggdGhlIGltbXV0YWJs
ZSByb290ZnMgcGFja2FnZS4NCj4gDQo+IFdoYXQgd2UgY291bGQgZG8gaXMNCj4gDQo+IGBgYCBy
ZWFkLW9ubHktcm9vdGZzLmJiY2xhc3MNCj4gUk9fUk9PVEZTX0VYQ0xVREVfRElSUyA/Pz0gIiIN
Cj4gYGBgDQo+IA0KPiBgYGAgY2lwLWNvcmUtaW1hZ2UuaW5jDQo+IFJPX1JPT1RGU19FWENMVURF
X0RJUlMgKz0gImJvb3QgaG9tZSB2YXIiDQo+IGBgYA0KPiANCj4gVGhlIHNxdWFzaGZzL2Vyb2Zz
IGNsYXNzZXMgc2hvdWxkIG5vdCBkZWZpbmUgYW55IGV4Y2x1c2lvbnMuDQoNCkhpLCB0aGF0J3Mg
YWxzbyBhIHZhbGlkIHBvaW50LiBVc3VhbGx5IHRoZSBleGx1c2lvbnMgYXJlIGRlZmluZWQgaW4g
dGhlDQp3a3Mgc2NyaXB0LCBidXQgaW4gY2FzZSBvZiBzcXVhc2hmcy9lcm9mcyB3ZSBkZXBsb3kg
ZnVsbCBmaWxlc3lzdGVtcyBhcw0KYmxvYnMsIHNvIHRoYXQgd29uJ3Qgd29yay4NCg0KQW55d2F5
cywgSSdtIGZpbmUgd2l0aCB5b3UgY2hhbmdlLCBhcyBsb25nIGFzIGl0IGFsc28gZXhjbHVkZXMg
L2Jvb3QgOikNCg0KRmVsaXgNCg0KPiANCj4gUXVpcmluDQo+ID4gSW4gbXkgb3BpbmlvbiwgdGhp
cyBzaG91bGQgYmUgZG9uZSBpbiB0aGUgaW1hZ2VycyBpbnN0ZWFkLg0KPiA+IA0KPiA+IEJlc3Qg
cmVnYXJkcywNCj4gPiBGZWxpeA0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gwqDCoGltYWdlX2NvbmZp
Z3VyZV9mc3RhYigpIHsNCj4gPiA+IMKgwqDCoMKgwqAgc3VkbyB0ZWUgJyR7SU1BR0VfUk9PVEZT
fS9ldGMvZnN0YWInIDw8IEVPRg0KPiA+ID4gwqDCoCMgQmVnaW4gL2V0Yy9mc3RhYg0KPiA+IA0K
PiANCg0KLS0gDQpTaWVtZW5zIEFHDQpMaW51eCBFeHBlcnQgQ2VudGVyDQpGcmllZHJpY2gtTHVk
d2lnLUJhdWVyLVN0ci4gMw0KODU3NDggR2FyY2hpbmcsIEdlcm1hbnkNCg0KDQo=


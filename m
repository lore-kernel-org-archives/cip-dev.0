Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B0C55187
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 17:24:49 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.113])
 by mx.groups.io with SMTP id smtpd.web08.3436.1649145554573437774
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Apr 2022 00:59:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=SV1FLvt+;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.113,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkDA9LVJcwuV+woH+a2gegSgh7g374vBCfV3wj9THT0kpnfSxH3RLvPE/LO2VpFTYQTcrON6vksG1atHXHBVRhadMNVup/84vprar/YW2ovwT/AEU1PjokFqvgTihlIjPZNJ01rd1vxkchi0FWcCOddCJ3gy8fSjdu7ag7oLJEztJk9/RYE3THKBgKsAEwVpZRm+WPuxuh7DkAzTPe5GjCCCczMkR41GCSU4cNoxkueH7jx5DfjrEyeXAV1e5n6odF7PrlbUZ44Wn4F7cmnpDAck1jbsrvKAGhC5u+Ubg9D9edSjob6kyP8VjRFc5JP2lg3XbhxnQkq8i+P2uytzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yan5E4A5GrveMoii+WgpO2e+dc/eM00eGw5EggY87x8=;
 b=GTItVb59FlRhwRGJE9GJQdIgZ6IyjYgcL6k/W7UG6fCJDMI8YovSkvzqCTTAljNRaXymCPqK1J00PF8/X0omscumDHyzp/DdQiEovQU4cDvHoBaD8eruUZcwA+k/Mdk3/9OOT+We9viAaTK0nAOGP9vsLwABTw6UK8xQLOStfoIIqIBXFy+v71hul32oErmnILo65LKCzKL2b4JQGaooftL7Bzpti1qADlkpIR2SClHkFqjKoQBKfkiGd2Ky501aa5pBmkRaQ2ICHVyuE/2Y+gX4nsTZo/7nN581NsXnNpBDygi1JXT1V10xTkM6FwK6L0/dn8zMn9J1/8BH+uwdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yan5E4A5GrveMoii+WgpO2e+dc/eM00eGw5EggY87x8=;
 b=SV1FLvt+Aihwtyr2cAP3Ob9hkKqDfUnJZ4iGRqRzqYuBv42MuM/VlB3iKG+RUMUNW0QgIdjqiu6MTjOvtToidCaKsHULXUCKUahpBVlMwp8nj4XdGghom5W2Z2ejeXbUSpWrRStlKHlxpDEDR1+xROKSolGMvajABA8HDFgwP+U=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB1778.jpnprd01.prod.outlook.com (2603:1096:603:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 07:59:08 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 07:59:08 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/29] Add RSPI/OSTM/WDT/TSU/OPP support to
 Renesas RZ/G2L SoC
Thread-Topic: [PATCH 5.10.y-cip 00/29] Add RSPI/OSTM/WDT/TSU/OPP support to
 Renesas RZ/G2L SoC
Thread-Index: AQHYSMEvEzwHM9n8Vku4x9wdFe6RLqzg9CLg
Date: Tue, 5 Apr 2022 07:59:08 +0000
Message-ID: 
 <OSZPR01MB7019621838F230696F1CFAC5AAE49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB6252C9162794F7FA3316653392E49@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB6252C9162794F7FA3316653392E49@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 512490b4-0ef6-40c9-94b2-08da16da29f9
x-ms-traffictypediagnostic: OSAPR01MB1778:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB1778F0FE73727BD3D3B87DAEAAE49@OSAPR01MB1778.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 D7jczBPiUbbIJBc+n4gAAVBKPXGEg2rUD0tAY6pbMb+TlMflshGmVuWvORKYA7K/tU6KREGgCxPYn5tFGdm0KDXCN3iKe4qiGpj9WVCIZTLtJ1PRJdF45rcVlRQUXkZdLdUXbXzbDsiOrj/NrbbZKubaRYmPDPrSpIImkDqkGnii6eSWjF9nLLHY0ttL/5X5UCAdcPKWfm2HA4t8x0LmqrHnpV8HKB2tx4e6KUpQmLH7soESEPlLQni5cbsqjqN1ZuRnx2qmr54OM//y2IR97peo8cyHwCHPqQXGStlGfLnO7mG843g1O0+ww3JnDQ1Qm3DEYuzMznlbWyFnDXJrqBKYCa8xxS3mP8BTGCLNfi4os6KiIFjz4q3uPLLkFqcIT7wfVxtrpXBGVDmi8c84SiWHTYD+f3yOUQDsgZAHyga0l0UNJVVs9s4E9a99PeLGB9rlQ5vViyUneIS2Guk8UdGtzY5WAweo/QPpSp+rACfByu8hhOI79MAc3JKB4smSPp3hBJrIqGqIPzvumf0KOYJDsIqqyfDGE91wEDRXb1vV3N14pVv5/YmSbg/mZuuo1VIpLlm09sBSCuF2owOA79Hoj0FIEUBl+DwOAGmng/c+xuzhw4v98vkOxrR9hrOkv5jhZue10P0dGnN4OlBjN7ycH351iwTnMc21GeGFZ9VydrYQL5kFkFSrT1x630EIAZhrbKuEuC5jhT/MQu33nw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(122000001)(9686003)(66946007)(52536014)(38100700002)(66446008)(8676002)(64756008)(66476007)(66556008)(4326008)(107886003)(2906002)(110136005)(71200400001)(8936002)(6506007)(7696005)(55016003)(53546011)(86362001)(316002)(83380400001)(186003)(26005)(33656002)(5660300002)(38070700005)(508600001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MDk2VXgvZzdDaGs5dTNhM2R0Vm5rR05ORFhZMS9FV2FjQXJoOEkvdDZjVnYw?=
 =?utf-8?B?bVYyYWhCSUM1Y1lNNnVFQmN6OHJuSENMMW5YWmtTRitJelQvbUMvRTJFS05R?=
 =?utf-8?B?d0hwR3N3aTQ1WWgyTnJSQjRTSVhuem1GckhMbi9HMDQxY2FrN0lvNHZtS0hI?=
 =?utf-8?B?UkU0UWFGQjR4YnBVYmxqVmZ2R3YvQ1Nyb2dWNzZJL1hIaU9nNTA1SnB2ZFpZ?=
 =?utf-8?B?SnJWY1hHbE1UVHZwNWZ4QXdtaEVWSFdEbWw0TzdpSTdZdE9oYWIwN0VkNC9W?=
 =?utf-8?B?T2FTSUR3ZmF4VVBlOEk3Mkh3ekVXYWNqck8xdWhUYzV1MklIQkdBZk9mUU45?=
 =?utf-8?B?TVg5ZG5iRFZzelF1b0V4bFBVaTF0UDFUL2hLVFR0RHYxbjFVcWwvTTBKRXJv?=
 =?utf-8?B?N2UxZDhGR3ZpaFRDTnhDcytSN3BYWGlMK0M4SGZlMXFxeVBNZzNNamd6R1hO?=
 =?utf-8?B?Z1E4OE5sY3ZadWN1Mzl6VWwyRmR1a0xXd0FNWHpNK1lWVTVUdVVYQkJ1c05k?=
 =?utf-8?B?YmJlMVFHRE1JSlJkV1grMGNpemNSU003YVBLSDVXa1pKL3pmdWFOcU01UzNl?=
 =?utf-8?B?RGkyRTM4Z3lQRzZVdUlkeE9tSXhnTm9EcFQ1amJ6cmZ3TzZINFFORXNCZlV4?=
 =?utf-8?B?RXpSRGoxV08zQnZBNDkzZk5FcEhha0RwVWxBdVZjSVFvYXpwSXlrdVRiL2Zh?=
 =?utf-8?B?clBnL1NPMGdQc05LbDZFTk8xako2cmMyTm80ZlhJckplUHpTdnNZcVZsYzF1?=
 =?utf-8?B?R045eG44dXdNcktBRGlWNXJSUS80N3lScmgxV2JjU3VFZ05zVTZuNzBhck51?=
 =?utf-8?B?TXNlU2oxZ0wzUDhpMVNiZFh1Vk9uYmg1bGVpaytQenhlclFlY0ZQT2x2N2po?=
 =?utf-8?B?Vm03SGF4ODgzaCtyRFFHb2l5SEhLUjRyYjZ1YmxQY0MyMmhDd2oyV054ZVho?=
 =?utf-8?B?VFk2enVETm0wblFzS2R3dnNBZllOZkdwOTFXT0VqdlBBSkRHMUlSa25jSy9J?=
 =?utf-8?B?QW5IWk5VeXJFQXJjeVRhSjF0QzRRYnZKYS9wN1Y4NGUydmtRWk5XVEY4T3Jw?=
 =?utf-8?B?cjllRG1RWml3NDBTb2RHcG44d0IxZFNTV1JOZG93WEhma2JCTDRITElmUFhQ?=
 =?utf-8?B?TWJTUjZmcnQwUjQ4NW9xa1FVUzdvOCs5U0FpdUhpNEQvWExrNjNIMHRBeGxN?=
 =?utf-8?B?aUdKcGZBK1lQWVBEVXZ4YmNFSjVZT2xHT0xIR0lzb2VuYnYrK1ZXdlVYZGpO?=
 =?utf-8?B?RXkzMEV3dEEyc2dpeXcxWXgydWROanA5VVJxdVRONW9DWlhucUV1emoyeWZQ?=
 =?utf-8?B?R1EwMFh1aWpjZ1dXNmdwenVvalJ2TFRheTgxZ2ZpWXAwRWcyZFMxaDVETmgw?=
 =?utf-8?B?akovUFhkYlRwUHUrdXN1b2JvZzh3U1VNVUxLVDZCSDYzbi96ekxadWVIdEp3?=
 =?utf-8?B?eEZhMlZRRzcyVytOTFpPVSswVlVBYkZBS2N6Q1JBdmIvdjRJRkdQSWx0S1BR?=
 =?utf-8?B?M1dLc2R3cE80ajRDY1BMOEdsdGpPeEthUXJZb0p5QTNUSVlCNEY5U0V3MUJs?=
 =?utf-8?B?ZkI1bVUwL3lqejVhMHVNQ0g2QmNVV0NNKzFUeFlJeTV5clJnaVVreWdVSzQ2?=
 =?utf-8?B?RFFWOC9xMG5QcnFnRUJleWdubHpuaEJTb2NveTZtWmVvOW9HWUhVSThkQ2M3?=
 =?utf-8?B?Mks5U1dUcG1qQjNQR0E2MUxVeEcrbldJbWFxSVVkSlZ0cmlVYVVkbjFxVVRU?=
 =?utf-8?B?ZmhxeEU2dXVTMVNvbkZWdGJCaWRCdkpzR0xVSlBVTjRCWXBxMjU4b3dleFdy?=
 =?utf-8?B?M1B1N2FQdXFsdDZ0Ry9zWlQ3L3F4VUR5OEdQUzVVeHdqazQ0MUlDTjlhaFBv?=
 =?utf-8?B?VXlRcjRpdW9RZHJuOG9ZclNzYWZiZ3ozNzdJeUluZlVCUVUxd0hWVEVuTHJ3?=
 =?utf-8?B?aGcwdWpqNFkwRXJqeWFzR3RCSXJLVWkvU2lWTnROd3ZkSkRnSHVqeVhwNjZk?=
 =?utf-8?B?bk9sQmEyNzE1MjYyQy9MaE1rYW1yU0VSWUpDZEQzbEd3Tnh6dnBlTVdJdGRl?=
 =?utf-8?B?UGRsKzR0NGFXOXplMXZVNVpiWUtzbndZRU41d0NuMzdEdmdhRXBnMXN5MjhZ?=
 =?utf-8?B?Ny9DNEZ3aDNDN2ZDZFFZNlpFL3NRdWM4czkvM1ZOaW5PRFpYME1yT0VHRG9V?=
 =?utf-8?B?VVRHSTJyR2txak9DMG5zaEpMQnpYRjJEa2lsS3NYbStBeW5RbXd6TzZsQmEy?=
 =?utf-8?B?K05vd2p1ZEVzY0xUcVZ6aWttSHRDNUlLcHdtRHhyM2Q0NGtLWEJLTkl3VkxX?=
 =?utf-8?B?Zk9tTlNYM0ZSZ0ttbS8rdmtQbVdqZWtTTktlYSs0MEV0QlM2eDVDekxYcXVz?=
 =?utf-8?Q?1iJYugF4X5KFe8i7TUqpcn9SglLUAW1tYvKCo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 512490b4-0ef6-40c9-94b2-08da16da29f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 07:59:08.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 gAHaymzJXX5GDIJbxW19urGuLDi2YhVGdeWVzR9QEYH6w+YCrPcpGLNI+yfxTzMyTbYhd4BwmOeOrOAfIxjBUUtqGkYV+b6FSM648qqs/no8V7LakKv/rEZ1Vf3ir9Us
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1778
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Apr 2022 17:24:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7997

SGkgTm9idWhpcm8sIFBhdmVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gU2VudDogMDUgQXByaWwgMjAyMiAwODo0Ng0KPiBUbzogUHJhYmhh
a2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+
OyBjaXAtDQo+IGRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbnguZGUNCj4gQ2M6
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQ
QVRDSCA1LjEwLnktY2lwIDAwLzI5XSBBZGQgUlNQSS9PU1RNL1dEVC9UU1UvT1BQIHN1cHBvcnQg
dG8NCj4gUmVuZXNhcyBSWi9HMkwgU29DDQo+IA0KPiBIaSBhbGwsDQo+IA0KPiA+DQo+ID4gSGkg
QWxsLA0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBmb2xsb3dp
bmcgdG8gUmVuZXNhcyBSWi9SR0wgU29DOg0KPiA+ICogUlNQSQ0KPiA+ICogV0RUDQo+ID4gKiBP
U1RNDQo+ID4gKiBUU1UvT1BQL0lQQQ0KPiA+DQo+ID4gQWxsIHRoZSBwYXRjaGVzIGhhdmUgYmVl
biBjaGVycnktcGlja2VkIGZyb20gdjUuMTcgcmVsZWFzZS4NCj4gDQo+IExvb2tzIGdvb2QgdG8g
bWUgdGhpcyBzZXJpZXMuDQo+IEkgYXBwbGllZCB0byBMaW51eC01LjEwLnktY2lwIHRyZWUuDQo+
IA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIGFjY2VwdGFuY2UuDQoNCkNoZWVycywN
ClByYWJoYWthcg0K


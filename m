Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225F2C433EF
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 15:03:07 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.46])
 by mx.groups.io with SMTP id smtpd.web10.5936.1655305385689476856
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jun 2022 08:03:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XFRjHqot;
 spf=pass (domain: siemens.com, ip: 40.107.22.46,
 mailfrom: florian.bezdeka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTNTyXYi8W6BLijDvVjYNEZDLwAOf8cUT+gci7d+K3Fz2g/lYaUWOIGjd9Or7oybe2xA3hyiVSz3i+DnVU5DpsnKKaRjz85kR0NeNiLMDCqG6UX+vkd4aI8IThQ+7CphBVx1FYzfKsiZRK9C0HkV03A/sP3d3dcuDo42CwagC2PegFop/ep1EwP0SUY/imJ087U4oRNR9xVSbALdJY/eLp1K6fYoSZoLhWa06XkLrylF2TULYenOuMERQEhWdi0wdepSgfWmRYqlDYyTtoFa6vDOwiNJimV9Ws3EDTAzvCj6HKV2iqopdNSDU6dgeC2CcilyZPCVWiHHe2q7Tl5pOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kez7bvjISsEgzr8zaKG68BykOhDAGfrPh43mkR29NxU=;
 b=HOGWAcYhzX3bputVYE1yVg8rx6umsTZ0yLMjjpvFcdXk1LrMLy0lV7HY0a7mXlyhAvh0mb6q8lqETr3GUqAb+fwWb5/tpbVjuYOEaf1hfmB/u9ZnxyLy5K2IeQW0maZ0DZdTf9xizMXW7Rkru290JqYIqWsxxjdSMGsN5GSCmuAafBOw75vcoR9Dxu8K8dKZjNq8W3IyYKtkEuCEkqWpXEfy6MJtB2VTxGs5vH/sYeLt60KEwaMqQVr5cn1KSaYuswnf0V4bQSlav5aZQg7rfyULnEZQ8+uPBubG8/EWb4n8SOdTfVNq9RoA6Qg4F1iMleUjCphxvGqaO74VG7JDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kez7bvjISsEgzr8zaKG68BykOhDAGfrPh43mkR29NxU=;
 b=XFRjHqotS6HZFJhu5cOttmyNv4995v9GWm8CgyBL5BMSTHqaayrunT27eOqZV6R7IjxcL1YmI8UakjVfdNqn9tRG4mIXQ5W8GNPdqMtjR/iSnPoDv6Fs7YfoGI9Lj1GXtLZucBhUKXZnjLQhkhmEO8ZgkNDl2PbfULnuDJupHtvUK9qbCvDrsu1ZvmMGuM8S4EsoPuu3GnADcw1NCgHiFf4PHxe9pjM6mRytXWU07n8GFUzpKtxTY3BTv0nGnogAtJ8krOd5b6slCafh7p4mrNaxpDENXBtZ4i4oFcmRxW44Rcos4D9VP4p1x4BLALWGStCFDPQ8FAZfrnUz57v1aQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 15 Jun
 2022 15:03:02 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd%3]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 15:03:02 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: [isar-cip-core] Build warning when SWUPDATE_BOOTLOAD != efibootguard
Thread-Topic: [isar-cip-core] Build warning when SWUPDATE_BOOTLOAD !=
 efibootguard
Thread-Index: AQHYgMkCbJFqIDEDm0eSAT+hDrR+gg==
Date: Wed, 15 Jun 2022 15:03:02 +0000
Message-ID: <22e98bbc8a23f5a88dd6f7131d79b83db89d6add.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95827036-6290-42db-fe0e-08da4ee024c1
x-ms-traffictypediagnostic: DB8PR10MB3340:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: 
 <DB8PR10MB3340A7A959CFDA92F5345445F6AD9@DB8PR10MB3340.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 H2h6XageWxRevP3OR4npqawWUCqqC2Zl6UGi5pH9kRImnft+06XTRW7uaGQ+PHQGEqqEX80rNUCEAXnN3dXv6z7yOx9HmqzWlM78A3TbLwfvISEGmRbCXzkSJ57orQVFaOXwNpnq1YbNRBKWsxETMUsliOC5q4p4RcQ6zMW6m/yWQy1EkfBZ/EKVmwSDKRqT9Adds/nYIQE/jhNo+wjDTEt/5fO7fCg1JVfidAl1e2t1RAE+q9LUqKc/3slKu6NUUn9gCb8QOGSQcdBf+PxabtwEQ5zOEUBb/ZKcnYtLd1stagsrlaEB1lkDE+oaQH7uu9qtZhyX5DnbWwMWA3imwCf2OXRjl6aIgDNVpcdE7IxP1W5hjrEO5N1mPwyDX4u2kYW8xK1zfeR33LTjEudt0KnGOOC51b65IXAREJvaNK6GQiPRT9bp/y7g7JQdBDCfr5kbbLeE3/k4FJOGGWFhzVaaepdWg3HDg9xdppgeMNMspkK7zAyu8Zx8p4JMvlViWjBFh0bLU8KFsSDvxPEN6WTr1D9hJuwaFTEaudjw0obkFMywjtPCKY48S+adRa/5iSoTUdQmu1OdHOPcyKfJPiUJwkJ54mZvJ4bLt1XgnpfTO+k2jncBY0wOQ1BypY3htBzwRpoV5xngFBYFogGkSCa2jPQU9jn4llsirgPrkowWqHZFiB5kJ2bkxkYS4YyiKTSIVn91mxEc701kyZLvH4hLxyDG3OYqh49gY7iATZw0X13NYiFYaw8p07M0gyUtOVBHyygJKLQCQ82zNPv6wXdLV5C//gecsLJ0g5KYAHs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6506007)(6512007)(36756003)(8936002)(2906002)(508600001)(122000001)(6486002)(966005)(38100700002)(38070700005)(66446008)(91956017)(4326008)(5660300002)(71200400001)(66556008)(8676002)(86362001)(6916009)(83380400001)(2616005)(82960400001)(54906003)(66476007)(107886003)(76116006)(186003)(316002)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SUpUdFl4SWc2VndIMVNkSUxScXhvVmZpeEtuNkJFVmVrNWs3TVdxZDgrcWFv?=
 =?utf-8?B?UkJWRVJXTDFFQi9rS2pRWnppaWppT3dpajliU1hJOFRyRCtXcWhnSnI3RXlD?=
 =?utf-8?B?dkhTclZWMTkwcVpKeUlQSmhMK2IwNWErUEZ2QzFEUkd2N09KaWFVUEt2cjll?=
 =?utf-8?B?UFRNTDV0SndrNjNaS2dNZTFQVXl3SnNOaXRpTS8waFI3SzFtVkxHeC84UzJS?=
 =?utf-8?B?L3VySlA5TXVib1BlUWpvYUJRZEg2VEJSZnRHbnZvc1VrbHdNdnJ2NmdTZm1Y?=
 =?utf-8?B?U2hMUHFGNmxwY0FhVmE4ZXRaTndLV1JqckZNUHp1REMzb0NWbU9EN3dZcXFH?=
 =?utf-8?B?TlFBRlBIOGl0aWo1Ui9HQ0U3NGdXdVRrMVRkbzZzSHZsL2c3aWlNWkN1MHla?=
 =?utf-8?B?T1c1cVRjdlR5dWs0aHJMaG9xSlkrb2hvcXhIeER6NDRTSVNGcUppNlZZelJ3?=
 =?utf-8?B?ZlIzTStWQ2FmOEhkdTMwUTE5UUoxSzN0NU44N3puVlVNRWxMeWNCNytTK0RO?=
 =?utf-8?B?SFNwOFN3bnR3ZmhzK29IOG03dktuQ1hoQlJHalZpTit5amh0cGF2TmdBZk4v?=
 =?utf-8?B?WkdsY3p4Z05SZE1NNXA3WEhYZ1BKRlFoUkVZVmIxYmdtOWlaQVdJM1JNdnFE?=
 =?utf-8?B?M0txY1NzbEcxSE4zdGx0MzZHYXVwT3pONG82N21yZDVtTWN4RitQZmkxODVX?=
 =?utf-8?B?ZTZWTTJLbDd2dVY4dVc5cTAwTENjOU5vSWhDU2dNMy9hTjZrOVVFekVuTDlH?=
 =?utf-8?B?MlZMZmhqb2JvaXJLUGdFUXNxOTB6aEM3YlkvK1BlRDZwamNCbjdHdSt2UGlH?=
 =?utf-8?B?U2ozbnlkWC96ZTFrTDFIMEVHTHltL0JnWG04Rkpva1BMRExCTWtPN2VaN2Q1?=
 =?utf-8?B?MjgxYVRDOXhaRTY1ZUxXd1N6NEdxa0VzdE1Jb0h5VWhrQjNwV1g3Z1pnYTBY?=
 =?utf-8?B?RXVFeFZ2TXRMRTJqME9IZGVBKzNPWnJuSmVob3pMcmtOTUl3dHRiYjhkVUw1?=
 =?utf-8?B?OGpDUjRMcUJ2dVNQbUgrSGlZMG81ZkJRU205TkFYRnZ1UGd5dGJIeE9aTUpa?=
 =?utf-8?B?cjNKVGJBWUhHb0JOa0hoMElwR3FFdUpqOTYrMk9QY2VCSXpxR09la2dOWFgy?=
 =?utf-8?B?MFZ2eGwvRGQ2MWE0bUFCQS8weHpudHhHUU5iWWJiclRFa3V3Zlo5ZkpBa0kv?=
 =?utf-8?B?OGVkM0QvNWl1U0EwUTRnU2EwdVd3YkJ2cm1IZU9MQzNvajJmYVUyZGJCVHdk?=
 =?utf-8?B?YjdSaktUMEREZzBWZENHbWFoc3ZtcGtwZzFnTURpdDh0eHNwcFFCaWlhbktR?=
 =?utf-8?B?N0lObU5kL0JlZ2dFeWo0RTJuUmJjR012dnNpanVrdW10a21qL0RHQUFCYmdw?=
 =?utf-8?B?VE5RbE0yQWZtcGp6OTZ3eTFQVU5Vanp2Rzhkc284VVViTHhNcXQzNFMzK1pl?=
 =?utf-8?B?Sm5PTXFqWGswMlNTNHVrbWVwNTJvYnFlcEhPWUJJNVJPSVBiNWRlL0hOT2cw?=
 =?utf-8?B?TGhFNWVtNTRYbExTNk9WZWpORk42Z213QnN4RGxpY2EyTWJYU0V4YTZmNWl2?=
 =?utf-8?B?VC9aTzdKZjYvbjVRZDh4bnFuZEtVTE9Ba09Objc3QTRmRkZCai9UeFZMYnRn?=
 =?utf-8?B?WThUekhuZW9pOXRLOE9UTnZ3NjNmblhUQ0pmYlRXbDFYSmRsa3NtbFZ6RWFl?=
 =?utf-8?B?NVIrNENUOCtWdTBNVmxlbGdTdlZTZGpRQ2pJdFNkeUtqd3d0Q1BmR1FxRWlJ?=
 =?utf-8?B?c3JBZTR2UjRhRmJ5SWJIRGhLcSswTVludGFCNHBsVGtYUGNtSFYyL016Lzgv?=
 =?utf-8?B?VjdCSklEWG1RSDIxR0xHTlVTdUg1L2lja2tneGdBVkZmQkNjM1JPWSs2MTlq?=
 =?utf-8?B?aHRjYUFacVpPSTYrT1VMeXpxRnhVdjExTVRZeSt5QmZ2bW1MalRxMHZhYW4r?=
 =?utf-8?B?MTRod3ExUjFhK2tsMFNweFRVREpiT1hKZ0hVSnpGS0tjckVuYmo1RzgzY08x?=
 =?utf-8?B?TmVseFNhRXEwSnlqeDFBdHQydXY4K1JPaVk0NkhlMUt5U3NManJ6d1plVGg1?=
 =?utf-8?B?VVVuSDhyMXZMT21GMHN1WW50WjlhUHQrcE5LQTR3NjlTUmw4K0VIZVlCYnNN?=
 =?utf-8?B?R2k5c1MvVDR6cWRyUENLMDJUR1BJbUJtZWdHRnIwaXVYWGQzVFJMcjFSN3Aw?=
 =?utf-8?B?R0l1N2NGTEhHR1F2RzBRR0E5V1dwUnFvN0xpWDF3djRXN2dsYU5FalpCY2Fy?=
 =?utf-8?B?aGJnOHkyME41d0crRW02dzN5U1Q2K3dhRlB6aWJyZVc2MW1jZTNNenNsYlla?=
 =?utf-8?B?a1N2QktlUmVKcEhDM1I2S2FtUUMrdXFTK0Z5V0c4cnRoTXBKNWpwMDQwM2dH?=
 =?utf-8?Q?OFcTyoF3o6/U50y+4AKBiVDHbQ3FEkHXQCk1p2CopmiD9?=
x-ms-exchange-antispam-messagedata-1: 
 HDy7rFC7wxZKXxG4gRPV8EDduvD432KiLUU3akBFQbpCFMVkkA3ANdk5
Content-Type: text/plain; charset="utf-8"
Content-ID: <676F65BAB41D51489B437B04BAD8BC06@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 95827036-6290-42db-fe0e-08da4ee024c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 15:03:02.2368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 WJKaEpCeQSfXXFb9iKLZDbe3YgKRFIuCUmwN34xj5d/nIEoHefHGvq0WihJU31g6ZHQHxwZUhH2unhouOUqFhG8LyLADLStoHiQocQI4iuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3340
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 15:03:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8565

SGksDQoNCndoZW4gdHJ5aW5nIHRvIGxpZnQgb25lIG9mIG91ciBpbnRlcm5hbCBJU0FSIGxheWVy
cyB0byByZWNlbnQgaXNhci1jaXAtDQpjb3JlIHZlcnNpb24gSSBnZXQgdGhlIGZvbGxvd2luZyBi
dWlsZCB3YXJuaW5nOg0KDQpXQVJOSU5HOiAvd29yay9jaXAtY29yZS9yZWNpcGVzLWNvcmUvc3d1
cGRhdGUtaGFuZGxlci0NCnJvdW5kcm9iaW4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluXzAu
MS5iYjrCoA0KVW5hYmxlIHRvIGdldCBjaGVja3N1bSBmb3Igc3d1cGRhdGUtaGFuZGxlci1yb3Vu
ZHJvYmluIFNSQ19VUkkgZW50cnkNCnN3dXBkYXRlLmhhbmRsZXIudS1ib290LmluaTogZmlsZSBj
b3VsZCBub3QgYmUgZm91bmQNCg0KVGhlIHN3dXBkYXRlLWhhbmRsZXItcm91bmRyb2JpbiByZWNp
cGUgKHdoaWNoIGlzIGFjdHVhbGx5IG5ldmVyIHVzZWQNCmhlcmUpIGhhcyBhIFNSQ19VUkkgbW9k
aWZpY2F0aW9uIChzZWUgWzFdKSB0aGF0IG9ubHkgd29ya3Mgd2hlbg0KU1dVUERBVEVfQk9PVExP
QURFUiBpcyBzZXQgdG8gZWZpYm9vdGd1YXJkLiBGb3IgYWxsIG90aGVyIHZhbHVlcyB0aGVyZQ0K
aXMgbm8gZ3VhcmFudGVlIHRoYXQgYSBkb3duc3RyZWFtIGxheWVyIHByb3ZpZGVzIHN1Y2ggYSBm
aWxlLg0KDQpJcyB0aGVyZSBhIHdheSBpbiBiaXRiYWtlIHRvIGNoZWNrIGlmIGEgZmlsZSBleGlz
dHMgc28gdGhhdCB3ZSBjb3VsZA0KYWRkIGl0IGNvbmRpdGlvbmFsbHkgdG8gU1JDX1VSST8NCg0K
Q2hhbmdpbmcgdGhlIGNvbmRpdGlvbiB0b8KgDQoJaWYgZC5nZXRWYXIoJ1NXVVBEQVRFX0JPT1RM
T0FERVInKSA9PSAnZWZpYm9vdGd1YXJkJw0Kd291bGQgcmVxdWlyZSBhbGwgZG93bnN0cmVhbSBs
YXllcnMgd2l0aCBTV1VQREFURV9CT09UTE9BREVSICE9DQplZmlib290Z3VhcmQgdG8gYWRkIHRo
ZSBmaWxlIG1hbnVhbGx5IHRvIFNSQ19VUkksIHNvIHRoZSBwYXR0ZXJuDQppbnRyb2R1Y2VkIGJ5
IFNXVVBEQVRFX1JPVU5EX1JPQklOX0hBTkRMRVJfQ09ORklHIGJyZWFrcy4NCg0KQW55IGlkZWFz
Pw0KDQpCZXN0IHJlZ2FyZHMsDQpGbG9yaWFuDQoNClsxXSBodHRwczovL2dpdGxhYi5jb20vY2lw
LXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL2Jsb2IvbWFzdGVyL3JlY2lwZXMtY29y
ZS9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmlu
XzAuMS5iYiNMMjENCg0KLS0gDQpTaWVtZW5zIEFHLCBUIENFRCBTRVMtREUNCkNvcnBvcmF0ZSBD
b21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0KDQo=


Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BF8EB64DC
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 07:37:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.3244.1689579461540689246
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 00:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 36H7bcvg2568771; Mon, 17 Jul 2023 16:37:39 +0900
X-Iguazu-Qid: 2rWhoCDaNSZJVuPzrY
X-Iguazu-QSIG: v=2; s=0; t=1689579458; q=2rWhoCDaNSZJVuPzrY; m=CBDfI5/EfHXt2qXhaCy4qydU/BxpGcO+yIkA3uWkUf8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 36H7bad71612548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Jul 2023 16:37:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og1vO98xFOb/VjaAwW+q46zDYcjve7V10LWSlh9/VttU2XwHsVRMJPrVi+hlIc/EcGa3vMR9okQZ63Wfe/eEzu0SnMtfFms5UGUp1iFNEG8DjEBQb2dOqhAJqdo9SWEoN4IJE1IyfmtJv0R+Mbg1yIlFVoP+IBDi0lJjEil9BQL9LaqG2FX74GVjxrYaZKfkjuQAv31Rr8Na4ZvRp81Vz3v6EsJnKgLX+rQqj4XZ9QMYbSsUoWHeSOMy+Q90N/kxQypLMMA4VmfGPRGSMxru4p0Q93AnrKrNO4wmEzKHajxZoP1f0DCKsAOMTpVVO9ydRW6vPNcHUZf4OY+aql4CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS8TVvFIrov4X9pbEjTrnxAgWuqmvVeSOvvb5WqCFuQ=;
 b=S2MDFvaYvY1pbnRQxmlkTjCRahUBbn5fqOUhD/GHugdCOG6oCNdbofLLl4xZVLchr0HihBKhaxXM9V0kUdWHUTstlQtd8TmPg74/PJGISBP9LAJS7Ct/lHJbY6jgeiuIwBrJk1ik2Inew4pRgpyLyDVnOdFlsOAo0EeWPcx5lH8YeFUeYbFuRLcugrfoVsVsoyfEobKVnE1MNpgy/3LWhEsVhZY23fKGDeWWDpdsOSvrrbMbznimc+9Bw9fELga9loVSviI0sID/BddPohcrFpclHaZ2FvCcStGeRdyTIQ58+Scx+HBLHoHqMnV/y9LNXzNlDRnMaYFUdT7qUMxjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] security.yml: Add additional features to security
 image
Thread-Topic: [isar-cip-core] security.yml: Add additional features to
 security image
Thread-Index: AQHZtLR2Pw2+Dja+gEy+l748u8HBXq+39oMAgADTxgCABM6/QA==
Date: Mon, 17 Jul 2023 07:37:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB49453BFD645F5F0732DD719FC23BA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
 <5b400f7b-4039-2fc8-5f84-2fe647ff8a3d@siemens.com>
 <fd3970a0-2375-6838-2d7d-182c6d392826@siemens.com>
In-Reply-To: <fd3970a0-2375-6838-2d7d-182c6d392826@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|OS3PR01MB9819:EE_
x-ms-office365-filtering-correlation-id: 7c004c2c-a60a-4cab-bbe4-08db8698b019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FIiMUJDmshiZg4LFXPde6u124mpWEXCnPPDW2h/4GvXsRKag3KMSz6taIBpBTejb0yzJC4ME3z+Xm+iqmMib4gL8Nwu5o7BX8pNGCPHmrgtI3nAbE7PGwiRXRS8/xtsz3uE/iZT8sfXdWd1XHbEhHqqgSonupPPfTvKdSOH3etQNKKX8H4GuA0UwLFztUauRKS5G/yRJOj77BEQ3zir+A85OALZtrUXftC+ayMOSEoWfFIdABMnh7JJmR6frIJINUI9TGAzf4eGuo2qartwQH/VqmfMnAjz4hYsdrnc6UAX5r4VEOeh6AN6JRnnGtZR6gV+s5Mdr7e4Ls7/jkc8oHKo8Afj/adp6q22jixXztCp6xFAqgT3R3dyb0DvjfAoZlI9w15EZ6KV5ouXd2CD8LqbyYakkc2pPdtiUfNKtmRjXHeoJwKNcOBAOqfJVhW0uyqV4yLA8Rh/ut6Oteq0r3TBtgwQFGPHLKzxiUDZFICb+HDLIIY5xJv5jTxbDJX1DHGVpzNc5JtOaE3E6zNJWzlVJ9DDHJ13Xxmc/YMUvwG9kJwWmoDoXo/Dd8lV8F8UmJgZQR5RZAehfSl54ne69QJlBz8tDvRvLhE2RXNEY6F1UraysxVJu2mr1Uci4csUs
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(7696005)(107886003)(26005)(6506007)(9686003)(53546011)(85182001)(122000001)(83380400001)(38070700005)(86362001)(38100700002)(33656002)(186003)(55016003)(8676002)(8936002)(2906002)(41300700001)(478600001)(4326008)(5660300002)(52536014)(316002)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(15650500001)(54906003)(110136005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y0Nqd2ZEdnBQWUp3c3lDdVlJNGtDanVjeHVydHFmWnVxdWZ1L2VlRWlEK3dw?=
 =?utf-8?B?c2lxZ0dFQ0I3WDQwMmxPYS9GbGdJYWI3TlVielE1ODVxT2FVSHRINzN0SHUw?=
 =?utf-8?B?a2NzU3hEVG1aa0F1TUwwazlOaXF0OGZEbkhJVmxqRlpWa0FlSG1JMUY2VzU1?=
 =?utf-8?B?cXNqbFVSM3RnTThlWGkvZnBxUTlSUzZidGVkcjBaL0o0SUFsd1NPaFIzbVVy?=
 =?utf-8?B?WEh6VjA0RmFXVXZBQkZLc0JnZFB4NnZOSld6S0hRaDFCeWxPRjNBR2xtV0FS?=
 =?utf-8?B?Qyt4dG1nc3ZOd2lxQS9hdStmRUZaMjZLeG4xOURwYk9QRWNZbmlhRmprYWNG?=
 =?utf-8?B?Wk0vRXllcjJUK0d3cW9hK2tDWlRjcllXalVkVEl4VEVITHZESGlyajQrQnRS?=
 =?utf-8?B?NkdUbjdEd2NwTVQ2ajB3NTlMT1lJaVh5UU1LS3NsVTMxZkQ1eHRoRThsakta?=
 =?utf-8?B?dzArMDRjNk1DYStOY2FWem5MY2JWaXFlK1JVbGlFREp1ekdrMGRYdEplKzVB?=
 =?utf-8?B?VnhKVWdwMnowOWR2WUhDcmNDNEs3OTQyeWYzdzRVV1AzT3FMUEZadERiTWxY?=
 =?utf-8?B?d3pFNEMyMDdMbnFqOWVtaTRuSk56NUxzaEQyLyt6YVpudjBoNnZ5SUROR0RH?=
 =?utf-8?B?UmtpTmxaUUJEazdsK2dqUWtnMDg4NTFMNGs5UXpERlNTQjNDaUJpSEhBc2p3?=
 =?utf-8?B?dGRGNG4rS1dienFzWmpaakNBSGZVVW1saWEyY0poQXNPS0JGSGUwamR2YVVH?=
 =?utf-8?B?SDBiL3UvOW5BMkIrTFdqZHkwaXRVZS9FNVRMQStnNzV2dHhDRFdTY1RlazlY?=
 =?utf-8?B?V0ZodytMMFZhSmEzdlJjVElUMUsrLzBYV3FFUHhwdFJicVdDaWlWR0xXSDJM?=
 =?utf-8?B?NzdjQWFveU1ONkI2OTFsK21MYUR4aGxYN2VBN2hLZURJZFMrQU5RVU0wQmhh?=
 =?utf-8?B?cFBSSmpHTC9sVUN6ZUJTeG9NSGt2Uy93c1FwamZNZVhzamhyb2ZPY2w3VmFW?=
 =?utf-8?B?bkQ1U0cwSEdGTDBCUnQ5MmZaNmd2ckZqUExwN0UveDRiTGc1aUt2ekE4N1cx?=
 =?utf-8?B?U0V6Zk9UYlduYkNWcUpDZWQ3QXo0NUVTZFFvbkFkYjFDQWpTMmdZWDUyZ29F?=
 =?utf-8?B?cy81WURPeGE0a21EWkhtaGdzWjFuTjc4SWYrTGNoZXZMcGZSNDRXd1A3TXc0?=
 =?utf-8?B?bS90OWZpVjZORHk1U25HRWRCYjlaTWIwN3IySlVaWlh6MEdFS21SUm45RmpY?=
 =?utf-8?B?SWdHeCtnLzcrSmRhaElBVzFTMjZBaHY2endDZEVhNExSWEJ2SDV1Tzk1ZklI?=
 =?utf-8?B?L0ZQYldndDRGdkdwMFNKK0tLUGMwRWphUDJ2dytVR2FuV2ZxVmUvZWRVMHY0?=
 =?utf-8?B?dWJGOXdvN0QyRmhxMzJpQTFRL2dYbTJYaENxUlF1T21HeEtHVWxiaUk0NElR?=
 =?utf-8?B?ZGRUOXlEeW1idUE2ekJQMWJiNmNPMStwdjJvZmZNeVQ4ZTdrTE84QW9FbVZP?=
 =?utf-8?B?QTdZMUl6VVBmZDBEUG5BUFoyaUt2cVQvZFBBVnBYUUxiSXRHa3MvNitzQUxJ?=
 =?utf-8?B?QU4xNHE5Y2NxZnJ0OVpZZC8yeG1yMUN3aGpuOFZKYkZqZSt5TW1aSE5Rb2xF?=
 =?utf-8?B?YjJkQnhoaUNwM0hzdmduTnlqbmFtOWFsSG5SN0YxQVZRazROYWRBL0R3VnJF?=
 =?utf-8?B?aEdiN0hjNkY1aHZKRk50a2NUTEJ1UGUyanpXUks3Rkh3YVN0L2lGTUZTTTdC?=
 =?utf-8?B?UG93SGpzc2p2VmxYbitFZUxBV2xPWWZ1VHQ5NmN6QkxQaFFxK1ZRd0ZCKzZB?=
 =?utf-8?B?ZXBqbkRDKy9ZWlBEUUxCYnFNQjlERkxDalc4VjFYNDVnT2lSZ2JlMnVqaTB3?=
 =?utf-8?B?cXRPWVpiSlVtR0ZKdC9SMmJONzdwMVBESFVOUEIzM0U4dDdVMENkeEdwNVh3?=
 =?utf-8?B?bk9xTXpvdFQxMk9hcVNkbTE1VTRRcjZSWldaYlZuU082V3NYNWgvcUVTK0lv?=
 =?utf-8?B?TUl6ZDBkdU5OTE16eTVOZ0k5ZE5PbFZxT1hLRkhvSjY5UDAxSzE2TkRiUlY1?=
 =?utf-8?B?V2tOUFBSVGJzUVVrd29tNFc4M0h1U2JwcUI5eEJpM3UzUWRpYklUR0FYRng1?=
 =?utf-8?B?ZmFndnQ4YXdmMnBRRjNTb1FMRkJRWTR1UGdlTU11aDY0ZFlxWUxqd0NiTExD?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hZFrcob3MG4dg4fxMPzisqE481f6f+roeKcpLL3a4HNfIuqf1a3ZC1m0wtvZVCYjnwTJj7HyhRoyGl0s7bX8QcWaOm0w0ZR7QGe0YFw4zRvFURQA2WWH+RoEdp5FL1p4FLQNCG+Z8zhQeO9Pg/ds15Nmn0T695Xs66Dx1cL3Hl26pRl4a2MUx4d1uwM4WyAeDT/N6j57TtgpThnTXB0cG5AQkMQZAcftBrwwl9t/v1d9eDdFofiTYWghaF4DXJRgDlNAenEZEyRJQ2s3he6p36eJDi+O9yt9iAdKfXbTmFMYDIqISTiMvbbIu/wXkn3DRscg6YEuXY1Gm4ECyddjrS07p09MB43+OvX+ZFQrIo8A1er5jztH31VmAkQlLaXHiHaCMvDQ3hNTtXtjE5NOaG+W1CSmViracO6iituorJk6+TD2x2WjvjIv2/88iFvJhJ24mc0/m4jM+0Skd6wKdUYOZmWJGBQHpA6zTfLfamU0GX8PW6tapvLKTZXWMsG26PDCq+CrBYiGn0pLXYISUIvPoUcHw22YNy4J5PxINj7/ORhHzdDYpDgo3TjGGpj5C5sv3z+s/sscHcqRPPyjv5CMRcg/e+U+XQPHWnfCPmN1QQz6yd6ZfvMbgaLhGdkyqGXxaVn/YwaBzJp9LmAXrKWg7ARqcrlgSLamZzoz8yqwi0fy78MTxOP6odipuaV6JQYM2sGUwDh7cQRHE/2wVFgDhhvD/JvWJ2iyuBvHvrfLyK/q4XFNkfFWttUyqb8np0mO/t5IrPvr9qQ56qSUtUdZJvFRmFMNlSUF9gSH9GjC3gUzjDdbOCoZ2ILhGlIGYIlsUM2zSSsmwn4r93w/Sw==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c004c2c-a60a-4cab-bbe4-08db8698b019
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 07:37:35.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akXAUNhCG8axAaCfdJFQNz+BUlmpiwHYI8zoGAvhxGMt8S6gqwSUpupZlaxH03v1/DcFzKkF0QTBEU0mcMoqbBFEqd4+Q9CSj94tAH+2370=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 07:37:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12363

SGkgSmFuLA0KDQpTbyB5b3UgbWVhbiB0byBzYXkgdGhhdCwgS2NvbmZpZyBmaWxlIG5lZWRzIHRv
IG1vZGlmaWVkIHNvIHRoYXQgdGhlIGV4dHJhIGZlYXR1cmVzIGFyZSBzZWxlY3RlZCB3aGVuIFNl
Y3VyaXR5IGV4dGVuc2lvbnMgaXMgc2VsZWN0ZWQgPw0KDQpSZWdhcmRzLA0KU2FpIEFzaHJpdGgg
KFQgUyBJIFApDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemth
IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAxNCwgMjAyMyAx
MTo0MCBBTQ0KVG86IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9z
aGliYS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNo
IGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3No
aWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vv
vKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3No
aWJhLmNvLmpwPg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXSBzZWN1cml0eS55bWw6IEFk
ZCBhZGRpdGlvbmFsIGZlYXR1cmVzIHRvIHNlY3VyaXR5IGltYWdlDQoNCk9uIDEzLjA3LjIzIDE5
OjMyLCBKYW4gS2lzemthIHdyb3RlOg0KPiBPbiAxMi4wNy4yMyAxMzozMSwgU2FpLlNhdGh1am9k
YUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogU2FpIDxTYWkuU2F0aHVqb2RhQHRv
c2hpYmEtdHNpcC5jb20+DQo+Pg0KPj4gRnJvbSBJRUMgY2VydGlmaWNhdGlvbiBwZXJzcGVjdGl2
ZSwgYSBzZWN1cml0eSBpbWFnZSBpcyBuZWVkZWQgd2hpY2ggaGFzIHRoZSBiZWxvdyBmZWF0dXJl
cyBhbG9uZyB3aXRoIHNlY3VyaXR5IGN1c3RvbWl6YXRpb25zLg0KPj4gMS4gRGF0YSBlbmNyeXB0
aW9uIChDUjQuMSkNCj4+IDIuIFNlY3VyZSBib290IChFRFIgMy4xNCkNCj4+IDMuIFNXdXBkYXRl
IChORFIgMy4xMCkNCj4+DQo+PiBUaGUgY29uZmlnLnlhbWwgd2lsbCBub3QgaGF2ZSB0aGUgZXh0
cmEgZW5hYmxlZCBmZWF0dXJlcyBhcyB0cnVlLiANCj4+IEhlbmNlIHRoZXkgc2hvdWxkIGJlIHBh
c3NlZCBpbiB0aGUgaW1hZ2UgcnVuIGNvbW1hbmQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2Fp
IDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICBkb2MvUkVBRE1F
LnNlY3VyaXR5LXRlc3RpbmcubWQgfCAyICstDQo+PiAga2FzL29wdC9zZWN1cml0eS55bWwgICAg
ICAgICAgIHwgMyArKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kb2MvUkVBRE1FLnNlY3VyaXR5LXRlc3Rp
bmcubWQgDQo+PiBiL2RvYy9SRUFETUUuc2VjdXJpdHktdGVzdGluZy5tZCBpbmRleCBjOTU0MGJl
Li45NzAwMGRhIDEwMDY0NA0KPj4gLS0tIGEvZG9jL1JFQURNRS5zZWN1cml0eS10ZXN0aW5nLm1k
DQo+PiArKysgYi9kb2MvUkVBRE1FLnNlY3VyaXR5LXRlc3RpbmcubWQNCj4+IEBAIC0zMyw3ICsz
Myw3IEBAIFNhdmUgJiBCdWlsZA0KPj4gIGBgYA0KPj4gICMgQm9vdCB0aGUgTGludXggaW1hZ2UN
Cj4+ICBgYGANCj4+IC1ob3N0JCAuL3N0YXJ0LXFlbXUuc2ggeDg2DQo+PiAraG9zdCQgU0VDVVJF
X0JPT1Q9InRydWUiIFRQTTJfRU5DUllQVElPTj0idHJ1ZSIgLi9zdGFydC1xZW11LnNoIHg4Ng0K
Pj4gIGBgYA0KPj4gIA0KPj4gICMgQ29weSBzZWN1cml0eSB0ZXN0cyBpbiB0byB0aGUgTGludXgg
aW1hZ2UgZGlmZiAtLWdpdCANCj4+IGEva2FzL29wdC9zZWN1cml0eS55bWwgYi9rYXMvb3B0L3Nl
Y3VyaXR5LnltbCBpbmRleCAxZjM3NDViLi5iMjFmMzMwIA0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9r
YXMvb3B0L3NlY3VyaXR5LnltbA0KPj4gKysrIGIva2FzL29wdC9zZWN1cml0eS55bWwNCj4+IEBA
IC0xMCw2ICsxMCw5IEBADQo+PiAgIw0KPj4gIGhlYWRlcjoNCj4+ICAgIHZlcnNpb246IDEyDQo+
PiArICBpbmNsdWRlczoNCj4+ICsgICAgLSBrYXMvb3B0L2VuY3J5cHQtcGFydGl0aW9ucy55bWwN
Cj4+ICsgICAgLSBrYXMvb3B0L2ViZy1zZWN1cmUtYm9vdC1zbmFrZW9pbC55bWwNCj4+ICANCj4+
ICB0YXJnZXQ6IGNpcC1jb3JlLWltYWdlLXNlY3VyaXR5DQo+PiAgDQo+IA0KPiBUaGFua3MsIHN0
aWxsIGFwcGxpZWQgZm9yIHRoZSByZWxlYXNlLg0KPiANCg0KQXJ0aWZhY3QgdXBsb2FkIHdhcyBi
cm9rZW4gYnkgdGhpcy4gQW5kIHRoZSBzaG91bGQgc3RpbGwgYWRqdXN0IEtjb25maWcgdG8gcmVm
bGVjdCB0aGUgaW1wbGljaXQgc2VsZWN0aW9uIG9mIHNlY3VyaXR5LnltbC4NCg0KSSdtIGRyb3Bw
aW5nIHRoaXMgZm9yIG5vdywgaXQncyBtb3JlIGNvbXBsaWNhdGVkLCBsaWtlbHkgdG9vIG11Y2gg
Zm9yIHRoaXMgcmVsZWFzZS4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpD
b21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K



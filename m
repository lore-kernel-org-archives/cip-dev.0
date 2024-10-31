Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171ADE68969
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 09:39:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.8608.1730367550656459819
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Oct 2024 02:39:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=L0pmvXC0;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1730367549;x=1731577149;bh=hACTu7IfKAJAlRRfs9Fvbnqw53XNcJwN5h/KcMN
	k6oA=;b=L0pmvXC0doLXXSDH53/5SXJBEhJYXjVWFykNV+DR8e81Z03miqoVKX1oyMCirxzi2jAiX
	HhFLTmeoVUAtVe8zkdYt6Hbo6RqLc+Xd1u6FtjO9q+3SPu1Q/GHUvR8+E9JdvMmMs2iAaIdAVeISf
	dfdaDK/VNYE8G+4/BBmwDMZDe8W4gbsmDl50MVEjnbvbVv0p7uBcyWrWcSpsb4ZOg5Sg9L4fIeVqy
	u0x4TiE++/rz1XsCEu38pHjvNANi3j04YOm+oX99JVxJyek3llIVoBuByyxqI9sWvDGxxs+RcFT7A
	hezUjU1RSBYnSekJ/8M6unBvI3JIleCIbGZUUHgAAw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 49V9d8KU2202429; Thu, 31 Oct 2024 18:39:09 +0900
X-Iguazu-Qid: 2yAaj8ZU4GKeBJQ2b2
X-Iguazu-QSIG: v=2; s=0; t=1730367548; q=2yAaj8ZU4GKeBJQ2b2; m=g9oBPV/gDivFwcT9eA3yyC59dnQn7BlEdH9y+wKoOfw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 49V9d7qU3350320
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 18:39:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvCITMHPVi6eOj4p0szwf48jk7t8L0ASIWzuJkx2SX0+ToT7e6sDILFZsWcHel0CZlBBurI+HAbP+kli8vqjRB486YqVAIdOtnFynOHxJlcfH7Ftjm8D/5XxLDh9Rpz1p3sTNWngoPWBHsoe6NC2R6f50ggzXhv0G833ZE7xSPiYlVK8HHjz2Zzbepu+XBBW2LpFVI6WiMoC9sLvEFGTRnJTnJ+w0hEt2USluZB0EtToOVTbljjHsCTejVL6HNSa7L3Q1MFlCVgDbWpMnrcDAGZvfZICFiEyNUB8DmFCXIJf68VXiriDYGKxX/AouGNwklWnKQpUCa2cCG4u6kEUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hACTu7IfKAJAlRRfs9Fvbnqw53XNcJwN5h/KcMNk6oA=;
 b=EiaUVxdBYu1tUbBISX7tKMnXrFqcRvKAuDezoDSWoVzUNf2eyPk7cC07VqNXcpUuzT0ueo/Q78jRJT1sz2DzlRokwksVOFo0GfTlXMHnPRYuFNybXobBB7Il7xfu/B5r4LHV7cA0vNZQ3Fx6dTJ+U7uFF2HtcWpWl+x5ouwcr6VpBw1OuFfTqhNUGl/Vgytv7MXAdlsu5y0QptZmAIv7n2FuUI5B2WNyCNamiXuYOZwsIfKVQ4GIe/w0EyUhViZtXm0s66PTeo+hrAmMIJ7PENFjF2682IazK16Jf6qT3HXkoWEe3kCwqfugd3wH6gu96hecfJFYiCkTiDL3LtjvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHbK3Z4oedWmPhSw0+d6k60NlLpLbKgmWhg
Date: Thu, 31 Oct 2024 09:39:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63883592C085D5894CB3DFFD92552@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <db161c4a-12dd-4a2a-b891-fd19547d3568@siemens.com>
In-Reply-To: <db161c4a-12dd-4a2a-b891-fd19547d3568@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB7098:EE_
x-ms-office365-filtering-correlation-id: 1e123243-a110-4017-ca5f-08dcf98fdcb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WGRsTmZJeUwxQXFLKzdQMXlEZ09rRjNaS1NHL1FKRXNqQmNWZ01ydldkMDY5?=
 =?utf-8?B?dks2M3ZmSkJzRzlad3hybUJIaTZYR2toMzU5b3dGN2t0N09OU3Y5YXo2WkhX?=
 =?utf-8?B?L0JCQnluMGxodHptSmRVV25NVllrR3lNYlJYMlRZUmJSaEI4STl1SVltUC83?=
 =?utf-8?B?TnVETllyZDBWcDNVR21xZHcxNlFnRGdzZDRnS0w4Z0xRZkVKVWFYZ0VlVUUv?=
 =?utf-8?B?bWZVVjhTU1VnbWgyc1RaKy9hRDFpVzYxNzZxS3F1MExRYm5rMlRwUXZTbzlS?=
 =?utf-8?B?Y3VWT0NJdlArUERGRUlaODkxOTZwdHVhbnduRkxVUm91MjVmVVZ0eVN4ZnNK?=
 =?utf-8?B?SThxR3ZOUmRPdkxtQWk2eWlhcit2NkplZlc3Y0x2Z0VOWkVUYWlyWGtqbnVH?=
 =?utf-8?B?Sm5maGJ5c2pTT0dUYmNkcExiZjFFUTNTQmVFUldzMlZFRDBGSWN6UGFwSkpp?=
 =?utf-8?B?ZktiL1BWZXN6V1I2SE8va0RXMWZ0SldxbjdUdWtTckFnZGJRRzZ0ZkpyOVRZ?=
 =?utf-8?B?K3JJSVdnRy9lR3pHSHlobkxyY0hhTUZmdnphQjRZUlNlSUZkTVprQkR6OFZJ?=
 =?utf-8?B?NzBNUnYxYzNTR21qSDd2c3NlNEluREhwTDkxaG9icmZ4Ym5JODJ3d0pNSGsy?=
 =?utf-8?B?SWJvb3hyV1JIcXdDbllUMkN3MXFwRTVodnVLNXBMSjNLYkJFWnc2ZUZvWGNk?=
 =?utf-8?B?cjBhRGRuUkFycC9ia2JzRU1YR3NYaHFKMTlTalFSSm84ZWRsRHZXbVhvdVA4?=
 =?utf-8?B?QVZzUjRXeHBKTnp1aGdSV0MvcXVpMXlWanJ3c2ZkZnJxc2g3a3VqUjk3M3Fh?=
 =?utf-8?B?NDR6QjNsVWZ3eERCWG05dGQzVDdsaDF5UFlBRGQ2dG5WcXJrVkwycEFTUVNv?=
 =?utf-8?B?L01zZ3I4ZFNQdVB2YWE3cHJSaFB4SllrSkcyYk5sQmdkWHN0RmlBUHJJZllz?=
 =?utf-8?B?NCsxcHhVeXYzYi9aVThqV0orRTJZSHl5S2YxUnVOSy9zVnl6eERqNnZON0VH?=
 =?utf-8?B?bWZydk9WSTIvZVFDTWVITm9nZjVyQ25ZZW52M2MvK0hJMWYxS0tHWVQ0K25Z?=
 =?utf-8?B?Yys0R3U4dERNZVcrbytFUVdIc25TZDA3eVViazZhbVdqbWhQd2xlVFV1UDJj?=
 =?utf-8?B?KzdqQWIydWVvdkpnMWVwdzU3cGNENmhZSkxxd0pabjk3Znp3eEVUYkFucWlZ?=
 =?utf-8?B?aXFJK3NONVY5NUpHQzF2SjllNStkRE9lZTBFL29CTCtmZjIrajdBNVdZeW5B?=
 =?utf-8?B?WURvb3lXU002YUxSTHVNaDRLeWZsbTZ6NC90V2pnakFPalNXR2lqV3RuWmlM?=
 =?utf-8?B?M2lacHVROHF6ek53TEp3WHlnaExSM09md3Y2MTcxL2xrU0pJUngzUTBZK3Qw?=
 =?utf-8?B?NGtLS3VZS25Iay9wL3hSK3JicG40VzVLMGU4Z1I5a1F6Uml3Q281MlRtYUd0?=
 =?utf-8?B?Vy9GQTYrRTluSDdiUExyS1I4ci84MVFvM2pYK3FEQThaK3dOTHNWN1JTazNj?=
 =?utf-8?B?d3M4aUpXdFV3MHdwalgveGladEVjMERSV1hvOXZFYWZ1YkxIYjJQb29IR0pC?=
 =?utf-8?B?WnZjckZLVHMvU2VDZHR6Z3FwSStNQ1FpVVhsL2w5aStvbnBsRHlGczlJbzJ2?=
 =?utf-8?B?ODFseGw2S2pwZ2RRaG9qVWlhMlc3OHBJNlFzMWhyeTJ3ZFFlWnJCazQvNlV0?=
 =?utf-8?B?Y2plbUhOVFUwbHppWnNyRXFWWmw4VmJ0MVFYb0YzUCtHVi84d3BOblFJNzNU?=
 =?utf-8?Q?EDJABChj3cvmTNx56ogcGUm0brtQu1SDm7aw1jg?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OFJTVERVODQ2TDQzeVlZS2tDcXREeWprSjBCTmx3K2hSZDRJWmk0dFpINlpK?=
 =?utf-8?B?Nk10cW9BcjdFczlUN0Uxd3NvWER0RzVxSHFrVEl6dnRJRFREVWpHREtFNjlh?=
 =?utf-8?B?Q2Vub3NoSmRmSjZ5dmFFSXJUc0ZVQTY2NmhFaHNIV1RVZURyNzJVRHozVHhh?=
 =?utf-8?B?WHIzREpMRHA5MTM4eWc5VjdrdWhqd1BuNStDZUs2L3l0V3ZVWUorR1NSdVNr?=
 =?utf-8?B?bkJ4UzRNSEdCdHoyVmtlTXp6MWNzNmF5VWN4ZW5pSnZWZmIzakF6dmdiamo3?=
 =?utf-8?B?UFRLVVBlTnJhb0d5ZlBMQVpzdVR6OFJZMmM0a0FDSEpTd0tCQXNGOXEzSEdL?=
 =?utf-8?B?WkdQSzkrdUVVZVZhQVdGWURpY2tlbDNiTVNLdkNYS1hUeEhIMjZyVzVITXZl?=
 =?utf-8?B?RXhEVGNETENrQ1kzVHdzR2pibTdkdjhZdVBMMzhpdElUeENHd3JoMFdWVndr?=
 =?utf-8?B?aFAwVWlhYTJBcWk3bWxTaFZsMjNGWXFhNHdIdHZMRXBkd09Id3M3SGRjbFZy?=
 =?utf-8?B?VFZqdUIydHJTWGkvbFdFSldFbWVyZ0JqR2I5R1B4SzNRN2hjUDIrdm5BL1l4?=
 =?utf-8?B?ZVdHZjRGb0VRM3JEeHZyRDUrMkZ0YkJ1ajYreVltL0VUQ0tyL1cxVnNONUhv?=
 =?utf-8?B?OGFMNjYrbk9FWS9oYkoxUHp0Ui9QeGFJZnRQWVBmL1VsNk9CRUJoek9MOEtz?=
 =?utf-8?B?MG1yZER6S3pseEJaNFEvYjBZM05ObzMrekZab2l0RFBXYkZNWElVcHlzd0xE?=
 =?utf-8?B?WVVTU3JFNjl3c0RjRVdVTmdMZGJjcksyTmxIZUh2U0tvSXc3S3ZBRnZKVUwx?=
 =?utf-8?B?Z0VZaW9FVDdNOWhLa0Z1WGFnb29jMG1uOWdkT0tWT0N1M1JBbVJCcGtaL0Zz?=
 =?utf-8?B?WVdrN0l5djNqZXdtQXdqWitMRkJxMm82d21wUUR6OFIzM0l5dGxNbVdEUVl3?=
 =?utf-8?B?WDRFekJUT2R5SWV6TVR6eEtPdkVZY3JaVlFUU3grREFYcjJKWW9tQjRpSnVP?=
 =?utf-8?B?bEk5ZVVLbDZBYlNBOUtGRFQ5UDJTQ2RMN2xxa1BSaGF6ZWpBUWlLSXU1ZUc5?=
 =?utf-8?B?eHVEeFQrVGlXTkVZSlhVOEZ0cmMyS3F6bDRKdlcrSVg2c0pSSHRhTUVjUUxC?=
 =?utf-8?B?NzJSYmZBS2p4TTRRK0FTaFhRYkRzYnoxbnc3djJFT2FNSWZuMU1UMzN0dE0y?=
 =?utf-8?B?OVlMNzRoblN1S2U4WGVORzlTblptbllRNW5jc3NNYkUxRHdrUmFtVDV1R3pO?=
 =?utf-8?B?K0VVZHIzb1ZzanBpNWJmZDUxWmtrVmdvUjJFL2VmU3ZxaSt1djlrOXl2d0h2?=
 =?utf-8?B?U2cwc08rdmdJYkptbHJzakdiV1c2VXBFVjhRdCtPd2dKeWwvMm9KakJ1azY3?=
 =?utf-8?B?TGU3cXozSW0zYldHL29pYWJFQlpjVmFIdUpwd05zcW9ZaWIzaFhnekpSQVlv?=
 =?utf-8?B?RnJTOExWTDN4cmZaM2pLeTIzNWdhR0VFZzBqQUQ0cHVOa3lsaW5VVklhVzF0?=
 =?utf-8?B?RGNPQ3REMVgydzB2SFErNkhVa3NSN3NwMW02YmpETWx1ZGk1WGlUbTczdWtV?=
 =?utf-8?B?emY4NWNTMHlhVWRPakhFMlM1aDNiK3dlWFFqaTR0VDloZmp5alZnbGlhNEUw?=
 =?utf-8?B?eFpDQjlhYTFRbzFWbktjeitUaXVDZW1Xc1dtclRCMUY5ZmNQeTFMalEzb3pi?=
 =?utf-8?B?R3ZWS2FpYW8raEZiVWNnWnBWbGJpRCs1cG8rTmdqUnRmTFV5MUcwOTc3ajZk?=
 =?utf-8?B?alFoenpyclVNcldXTnN1SDFpNnROZmErd2dRMkdHcjY0WXNqc2tkaXVGdnNK?=
 =?utf-8?B?UmNxcmZ6UGU1K2xRaC8vQ05yVjFXYmlMWE95S3lQak1JVlU0N2k1SGhWNGxa?=
 =?utf-8?B?UnJoN3JjSHNnYmR5bXE3aTlLSlk3OUt1R0E1Z2VnNTVRTEx2R2xaRjh1VW9v?=
 =?utf-8?B?WjFKWXh2b3ZwcmlBcmJtcnI0aWVpek5PdlJZUkpIVFBHTFI5M0JOVDl2Q05Q?=
 =?utf-8?B?S0xMVnVWWGhTWStwTk5FYUpaeGd2NmVnYmVxUFZUKzdmOUdseHZZUmc0V3Yw?=
 =?utf-8?B?a3h1Mzdtb0U2VDFySFpkVTNQVkRXNFNBNzBuSDdKYS9BcHRiUFZuUEVEZmpj?=
 =?utf-8?B?ZUIxZmI3UDhtQ1dFY3JvaEluaFQrZFhUaVRkakNGeHNIVi93bVZ3c2JzSDh5?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e123243-a110-4017-ca5f-08dcf98fdcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 09:39:05.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4NQzk2l1J8sgkHF38NajfOTS6OPoe1hmtkkCwFw927PbLRjmJxsNRy6J2EGAxbQMy4/MKUtreVk7VNBQE/6EKlixtDZRUBqt2SRXzniSau+p0O0S9hURb35aHyLAYrK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7098
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Oct 2024 09:39:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17129

SGkgSmFuLA0KDQpJIGNhbiBub3QgcGFydGljaXBhdGUgdG9kYXkncyBtZWV0aW5nIGZvciBwZXJz
b25hbCByZWFzb24sIHNvcnJ5Lg0KDQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkgYmUgcmVt
aW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNz
DQo+IHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5LiBPdXIgY2hhbm5lbCBp
cyB0aGUgZm9sbG93aW5nOg0KPiANCj4gICAgIGlyYzppcmMubGliZXJhLmNoYXQ6NjY2Ny9jaXAN
Cj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDEzOjAwOg0K
PiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFp
bHMuaHRtbD95ZWFyPTIwMjQmDQo+IG1vbnRoPTEwJmRheT0zMSZob3VyPTEzJm1pbj0wJnNlYz0w
JnAxPTIyNCZwMj0xNzkmcDM9MTM2JnA0DQo+ID0zNyZwNT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dl
c3QgICAgVVNFYXN0ICAgIFVLICAgICAgICBERSAgICAgICAgVFcgICAgICAgIEpQDQo+IDA2OjAw
ICAgICAwOTowMCAgICAgMTM6MDAgICAgIDE0OjAwICAgICAyMTowMCAgICAgMjI6MDANCj4gDQo+
IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2JvdC53bC5saW51eGZvdW5kYXRp
b24ub3JnL21lZXRpbmdzL2NpcC8yMDI0LzEwL2NpcC4yMDI0LTEwLTI0LQ0KPiAxMy4wNC5sb2cu
aHRtbA0KPiANCj4gKiBBY3Rpb24gaXRlbXMNCj4gICAtIHByZXBhcmUgYmxvZyBlbnRyeSBvbiBT
TFRTIGtlcm5lbCBzdGF0ZSBhbmQgY2hhbGxlbmdlcyBbSmFuXQ0KPiAqIEtlcm5lbCBtYWludGVu
YW5jZSB1cGRhdGVzDQoNCkkgYW0gcmV2aWV3aW5nIGxpbnV4LTYuMS55LXJjLg0KDQo+ICogS2Vy
bmVsIHJlbGVhc2Ugc3RhdHVzIFsqXQ0KDQo+IGxpbnV4LTQuMTkueS1jaXA6IGludGVydmFsIDMw
IGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVlIFNlcCAyNCAwOTozMjoz
NyBBTSBVVEMgMjAyNA0KPiAgIGxpbWl0IGRhdGU6IFRodSBPY3QgMjQgMDk6MzI6MzcgQU0gVVRD
IDIwMjQNCj4gICBTdGF0dXM6IExhdGUNCg0KU2luY2UgNC4xOS55IExUUyBoYXMgbm90IGJlZW4g
cmVsZWFzZWQsIENJUCBoYXMgbm90IGJlZW4gcmVsZWFzZWQgZWl0aGVyLg0KSSBhbm5vdW5jZWQg
YWJvdXQgdGhpcyBhdCBNTC4NCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvY2lwLWRldi9PUzBQ
UjAxTUI2Mzg4RDZFMUVCMTBCMTk1MzlENENGQjY5MjU1MkBPUzBQUjAxTUI2Mzg4LmpwbnByZDAx
LnByb2Qub3V0bG9vay5jb20vVC8jdQ0KDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIEFPQg0K
PiANCj4gSmFuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==



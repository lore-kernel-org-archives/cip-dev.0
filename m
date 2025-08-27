Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA84CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 07:37:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.9699.1756280239343284290
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Aug 2025 00:37:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=olspvfyO;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1756280223;x=1757489823;bh=wkCpMmOdVAPjIml+TQxPSMbKQhq1xTlTiNXya
	PhzBFk=;b=olspvfyOboloixbJCE8aemC3fZxz8HA2G9cMe4lpRiE+24g2HaBYfyGbRvf2FxlT4iT
	nyCGHiDVoLSDF0jIdSbpa6sfpHHCK4IXGEKJfVxtnowmrk5axbKrmiA47ByeGKusl4ldgVtbFs1sn
	/4VkITk9k0VF/LTvMekV4YSygl1lW3UYULjSbt5T//Lrw7kriTOgAmFYnLa830lyM/kj8FpsjLOEq
	6feroLZTEn/FdyayFQDJsZ4TVcsjs6hWCir9bY/vQpgplzOLasHVj2UhMIRpk0h6mtLDjPdghkL26
	nB6s06bctBrWhl6jLGHCm0p00+00AahI6hiPfjCHJw5w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 57R7b2N22753251; Wed, 27 Aug 2025 16:37:03 +0900
X-Iguazu-Qid: 2yAbaKzOlGOwmsa8Cy
X-Iguazu-QSIG: v=2; s=0; t=1756280221; q=2yAbaKzOlGOwmsa8Cy; m=F7Dy8YkG1ah/Lawd+bKbZKTYQyfbqkjtd/XugHuq2WM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cBbvc4WcpzyPZ; Wed, 27 Aug 2025 16:37:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj5O7yD87iZpSzS5V1q526nMK9JjkKIU8F/vOo4hgX1vaKQP1Lk0rDxPfI8So7oAUr/ZiX2NnNhIFKxhxCjd7b7Z6egzgQN8M+Vs4pfjf0C3GyzbsDIThD3JyIWPGP78/cpF4qTBlECD6firwKAOnXUWEYmb2wK/G0Os1wv1QVSALgN8XhB2gWtFtYcpmkOcsHvHZvyPqH8Nol3+H+oNOS4CBx830FjlbL7obZR6e3QzP0iLA9vp1ku1/ob5h3NidsNYUeXLtZskWfajhSMcA526YAZ24AUwZvEINtQ7goUb4MtowYedYiqENCLYSC3LFgwuRK0IxX4MPD8Fs3APaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkCpMmOdVAPjIml+TQxPSMbKQhq1xTlTiNXyaPhzBFk=;
 b=NArSM/ZaG3c1sDxaJkjqlopvdkwvim6ZVGKIYgLkVYOW59JnXRjyjskwkfLAgsZjbTF0mtVBuI5y3Md85NHxiUZIH2javZO17I8wQbkqQxHaBsZ0pYy5cq3VV6iEQ4k2mfUy2n7Si2cg23tqSKGapiArrx4P3GjeYNrF1sQrGre3Eg389J2Jf4IEYvI6VxqWIWcOs5MATvBM5cLQwX+wAV2FJvjRuj0007rK9y5NeHZpfLP1VHwRGCkPsnoBBM7YveJk3dz+c1BsqOOqQK+g2V4EdqQTDPHYSdBM6tlftyBbGVmUNBBOUXDRuuWAL+vnazJcfItDzPZymLbGS1johA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.4-st67, 4.4-cip102
Thread-Topic: Request for review for 4.4-st67, 4.4-cip102
Thread-Index: AQHcFC6sYfNBhDwwg0+I5uw48dNYcLR2IcGQ
Date: Wed, 27 Aug 2025 07:36:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DD6C4FE47F084E337BADCD38A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1277181115.2080.1755954343886@webmail.strato.de>
In-Reply-To: <1277181115.2080.1755954343886@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB9539:EE_
x-ms-office365-filtering-correlation-id: c5f6f84c-723a-410a-1dc0-08dde53c814c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y29Eb2JXR2VjY2ZWTzA3V1ZndXV4ckFyUGpKbG0yT1VqQWhzMGtaeFhJMVV1?=
 =?utf-8?B?MkllalBVUXJOb0J6L1VIeVBpajlGbWZGS29YbUNMa1RMOHVpMDh3QzNLUmlI?=
 =?utf-8?B?Mk01QnB1WG5tejNqY3prUy9hZVdYdEtmTkQrVlNpcktQYno4elFtUjdEMHlD?=
 =?utf-8?B?S200TWF2bnd2UjlzdmwzZ2NVc0F6NjM5bDc4ZUVRb0NqT2djM3RGenRLcmlH?=
 =?utf-8?B?dDdnYWRuaFF6ZGNzN01PZEk0SXNYcUh6SW5iVUpjbUpwcnJWRm9CZ0tlZUh0?=
 =?utf-8?B?UmJaVWsrbG93b0VESXRBbit6Z3EvZ1EzaFJadFFtTVJjQzJaUVlCYkNtLzN5?=
 =?utf-8?B?dElmbXdmSkpYazFJbmZheXBvSkVCNG4zNFlvWU0zSllVbTJoRGxOTjArcWs3?=
 =?utf-8?B?NmYwQ3ZWZmZYY29OYUtmUDEvNC9rc3VlaSs0Q09ZVUc5OXRrYkFpbnRpSWZQ?=
 =?utf-8?B?OGZBa2thenZEVENqRDVZZi9DbFFRd0IzZ3ZUKzh6eVdkbkhpY2N3QjBGQWJE?=
 =?utf-8?B?Zmc5NDFzdVlzYXd1cFNGNTJaVmQ3Z3h6Q3FWZDNVSEhXODFrV3BPWHRCQTZl?=
 =?utf-8?B?eXN5REx5RjNXS2ZYcytTQ2w5OXpxSFdRWmtYT0EvWFY4K0pUVm5nRVRlTkNV?=
 =?utf-8?B?a0tPQW9YWjhwWURIYkQwYkxiT1JwYVYyN2VSbXh6MUlXWUZWUVlDUzJqWW4v?=
 =?utf-8?B?SHhObFlLZUlkQldEQ2kxYm8wbnpReXRUVHYxQlhROU1KMkV1ZGtueFV4My9N?=
 =?utf-8?B?aHlUNXVGekwyM2dyTjlPbWZScS9XTzh2dGYwUThSOXhyVmhONVZNNWEwZEt6?=
 =?utf-8?B?ZUt6RUhtTHVzZlQrZzUrM2lvdlZMYlp0RDN3U3hSMFl2akltQVMyWVFoR252?=
 =?utf-8?B?TUhENld5Q2xIUWV6THozVVhRM2ZGdnhFSW5lVlY3NUpEdnhnTDNkQkpsWlUr?=
 =?utf-8?B?bnZ0dzdoMkxwU2xqd3dyM0hJMlZONnhvemF3RTdQSzJ4M2pQVlhLOERBd0Iw?=
 =?utf-8?B?MlJUbkt3Yk9Vb0UxVlRSTlMySjB3Z3lpNUxNQzBFVHJMZkxEdDlRd1FONitS?=
 =?utf-8?B?UVB6eW1Pc1FxTDZIVCtvQTliYjlzaTNsZTZDWDNGaWdDR2hFYVk2TEh1Slhl?=
 =?utf-8?B?R2xNVzZGaTRVSk5oWVlBeFlWYUVleklkZW93NXNSa2NtVk5rd09CS0NZRkxC?=
 =?utf-8?B?RWNJWUw5RHFpR3pKcnlpcFNibEZaZUlpZHY3TGlQajRmZGJZa2pGTmFyM3N0?=
 =?utf-8?B?bFhJa21Rb1VZbTNWUFpXMVZGWXNwQXhpTHhJdTNuNzRjWElDeG9uT3hTNFVp?=
 =?utf-8?B?NGg0dFV0eDVoeFRsa1dIOVFad3Q1eFpmaHpDY29SVHVkczdIcFpuNzZSa0FQ?=
 =?utf-8?B?ZlBsQTk0OUpPUUZXcXhXR2w5amIwSDU1SVBJelBLbHlIS2pjRENjUGpxRm9x?=
 =?utf-8?B?dTRYT3dyMnYxa3hzZ1ZCQkE0OGFjb0FsdXJuUEtVQ1Y3dDRBWEZWczVLRVNH?=
 =?utf-8?B?SlV0WFhPbC95RHBaNHRKSzNEVHZuSWdwRjVGdmVFaWwvbmY4QWlWZ0tINDd2?=
 =?utf-8?B?T1YyNzRUV3U4RGFlbHdjT2xaSFhFSlBVM0gvUmhUdDhkQWdrRzYzREdJTUpE?=
 =?utf-8?B?MC9kZ050T0lNNXc0d1lxSGZBRm9PWFdjT2gxYlQrL0JJNElmaThlWE8xSG5l?=
 =?utf-8?B?NzJSSGV5NkhDeFNwTWE1dmFnMDcvMTVOMnpyMytZblo4RmZNcHRwQlpxYi9T?=
 =?utf-8?B?bE9lRjZ1T3hxaW1wcUVOSFJjSWNYbDE5TUZVYUM2by9kbVhZdG1wdnptMWM3?=
 =?utf-8?B?a2l1cmxiSlNDYlpPOFlBeHVwcndVVTRzNkJrSjBKL09TejNGb3B3VEswdTBG?=
 =?utf-8?B?YUc1VVVqNFJBMFdzc1IxM0NDZWJSVXlFQ01UZnFqKzhhU2Q5U1FBVGdsNVUz?=
 =?utf-8?B?bC9pamtmcXdiaGJWZlljYWo5bHFrMHVFU3Y0TVo5SzQ1VTlRT2ROQUNMVVVC?=
 =?utf-8?Q?wpl3dXNjVUrhltv7+IGYiRsxhBjqt0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U1ZVVVd2cXJraWJlcjZkTVRzamV5QmF3QXFFU0cwZk44b1N6ckhURDRWb0w5?=
 =?utf-8?B?djIraTBSQlEyYVBmRUVSSFhkMDY2SHg2YzgxQWNKeFRib3dZbXJKVGlFQjRN?=
 =?utf-8?B?QWVaSnBEUnVBMnF5S05RNXBCclRLK1BFY1NUNHFNcEpWTmVCRFY0ZHhyTyt0?=
 =?utf-8?B?QVA5ZndIQUNYUTlGc1o0VFhZVkx5Uk5ZVlkwdE5hVHBxUU1vVFFFeGNWbkJJ?=
 =?utf-8?B?VlBjNDRma042bnVHNVlFZzRBejBmTXFEeTRUMmhTSTNyWk5rU2NDVnB6cUlQ?=
 =?utf-8?B?K25JSXVySUpMNkJ6ODR5eFZxU3ZpRUhraThsMGt1QzhuZDZFcGtMZzVxQW92?=
 =?utf-8?B?L1RGSUE1L2ZadnVrQ1JVNFNLYlBsUXUvL3JjRjUxV3Mwb1V2Z1draUlQM0pJ?=
 =?utf-8?B?cEl6YVphVjhzaTVkNzJpM3lqZDE1V2dYMFM2S2ZpMnRXKzJrenhmVWg5cU9j?=
 =?utf-8?B?ekYwcUZwRmtiUUtJMW1HVG82d3NlV1IvaS84RUZSNjZvUTRIbGZEVkxteDh1?=
 =?utf-8?B?R3FDK0lrQUtjZVdncDVNUVRNLzZLa3lSMUR0ZmJHNnJEdS9YWVVFYjVjR3h3?=
 =?utf-8?B?RlN3ejZTdlFaMjBwMVZUdlVoZldXSVpCUVhvNGlOanl0SlRCaWZZS3ZWQlRu?=
 =?utf-8?B?bFFESkVQY1BRYVoyR1dIZkNtTXBRcTZkdlNSTU9hekpERko3Zkt5U1BQK3U5?=
 =?utf-8?B?T0RlYkdHR2ZPL2lNQThFUjlUMzg4UVJZNGNpQStEQ3AvcGdKb2wycWJlaU5O?=
 =?utf-8?B?eFhsMWg4ODhSWEhGVGJDV24za3BKZndzUmlnYW5YbitvOTJZWUtzT3VXMktJ?=
 =?utf-8?B?aXBQWE1ockQ3dzQ3K1lONmdEYXp6ek01bUdmWFVBMVpOenA1UlI3OUxlbUxT?=
 =?utf-8?B?US9IQmpQZCs1bzFpem9tRmcrQmhSVmQzZjEvUzdUODJYaWVLdFQxRDhQbnVY?=
 =?utf-8?B?czlqTnR4VUtuY1dsZThSUnVXSmM2Y3hpVTFoWVZzMlEvV0VxQTgzSkRQTys2?=
 =?utf-8?B?VWlKcmJSTHlBb3YyRnN6cko0VXF5U0s4OTBaN1NDQ2RnZ3ljVmR5dnNuNm1a?=
 =?utf-8?B?TURkeHVRZ0FUU2ptRW91ZVJxQ3MwbEVUR2IyMHBhZDZaV0Noalg4M0JTOUZi?=
 =?utf-8?B?UEI5OWJVSWZ1em42T0xWSHZDSzFZcW9nRzZZUjE0SmJCOEhnZDJMRG9OSi9q?=
 =?utf-8?B?UkFyWjBIbTIwcllKRkxaNDdHaDBlTXBuTDA5L29lS204RzZYQlI1SlUzQ2lr?=
 =?utf-8?B?QmoyNks5cWVNenpncVhHY1NoUkpZZDJnZFRSVUxuQlZ3bGNtZnQrVjZReWVK?=
 =?utf-8?B?RmRxL2t2R29IemR2L1U1SmZubkhwWVljd21mQldTWkZiMEdtNSttNkpFOFQ4?=
 =?utf-8?B?YTdEQUllVUhSUExndFBHQzlrZ3BqRzAzbVdVWkVDZE1hdFd1endoNEZWclgx?=
 =?utf-8?B?ckxycW1YTTM5bGFwU0NkWDVISVh3RVFsQ3dreWF3RTFMRlFTSmtDc3ZZOEp3?=
 =?utf-8?B?Vzl5VE1yOUdmQnpHWHZtMkN2WDNkbFNNQ2FINmhsR1dScVBtVWpkL2k5N2w0?=
 =?utf-8?B?UGtlSjZmY204YzFrSDZkZ2JOQ2I2ekdRNU4zV1Rza1hqb2RDVlZGaUl6S2xZ?=
 =?utf-8?B?NDA0SS9wYmcxS1I0NzBLRzd3WlhDajRkMHg4QzJqMDdudkhpRUlXa1BBN3Vi?=
 =?utf-8?B?VVlySHZjTHlpWEM4cGhkWjZldHFQOXd1MGhaV2h5SjExUWtEWER1SVB3eEJQ?=
 =?utf-8?B?NXNXcnpyN0g2V0pHc3ptdmZFVDJYUStwamw4dTdaK1hOb1ZoZ05BOUNQTWxz?=
 =?utf-8?B?ZHFZOHE2NHVubGN3cmtkSTV1QSs5R1c2Y1lFRGZ6Tll1VEVyQkhiVnBUd0ow?=
 =?utf-8?B?RDYvbGVHYUJMTkU5NExlNm1CaVV0WXBmRVBzWERzcjhHVThaTm5IM3drM0tp?=
 =?utf-8?B?V09vSlRrQXF0Tmw1RmVyckdERHBrNC9iaHArU1lyTlJLN2xqL3ptMHZKck9j?=
 =?utf-8?B?YVI1OVcvOWs5NE9kZEhHRm9XWndTU1NPS25sSUJhR1VCRmx4OW9DZ0o1Nks0?=
 =?utf-8?B?TE5PNndSdy9zZXJOOHdoYjUzY2dwNmdkVkQwOTNYbng4M2RkN2dFdENkZ1Qy?=
 =?utf-8?B?QzZTNGtxMlBlelZ6alpGcVVGMnplYklCNXZNVDZ2M1JqRzlYbnFJZGthalh5?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f6f84c-723a-410a-1dc0-08dde53c814c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 07:36:58.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQrsqlrlFwLjOQMe4rzAz2C/+0lO64nFcmi8QBJ5XGXn1FdOgP7BNUvH2jnIwojQ2H7aWWT8AiB1vYrlUrpeDNNiiZ+zPpXxKYMR25kyPHDQ3cXMRiyE3OJPfw0b68Hv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9539
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 07:37:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19975

SGkgVWxyaWNoLA0KDQpUaGFua3MgZm9yIHlvdSB3b3JrIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFVscmljaCBIZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBT
YXR1cmRheSwgQXVndXN0IDIzLCAyMDI1IDEwOjA2IFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZzsgcGF2ZWxAZGVueC5kZTsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/
oQ0KPiDmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8bm9idWhpcm8uaXdhbWF0c3Uu
eDkwQG1haWwudG9zaGliYT4NCj4gU3ViamVjdDogUmVxdWVzdCBmb3IgcmV2aWV3IGZvciA0LjQt
c3Q2NywgNC40LWNpcDEwMg0KPiANCj4gSGkhDQo+IA0KPiBIZXJlIGFyZSB0aGUgbWFudWFsIGJh
Y2twb3J0cyBmb3IgdGhlIHVwY29taW5nIDQuNCBrZXJuZWwgcmVsZWFzZS4gQXMgYWx3YXlzDQo+
IHRoZXkgY2FuIGJlIGZvdW5kIGluDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0L2xvZy8/aD1saW51DQo+IHgtNC40Lnkt
c3QtcmMNCj4gDQo+IDIyOWVhZTExNmI1YzAgbXRrLXNkOiBQcmV2ZW50IG1lbW9yeSBjb3JydXB0
aW9uIGZyb20gRE1BIG1hcCBmYWlsdXJlDQo+IDA2YzBhNTAxNGRhZTUgYnRyZnM6IGRvbid0IGFi
b3J0IGZpbGVzeXN0ZW0gd2hlbiBhdHRlbXB0aW5nIHRvIHNuYXBzaG90DQo+IGRlbGV0ZWQgc3Vi
dm9sdW1lDQo+IGY5ODQyZjA3YjlhMjAgbmV0OiBpcHY2OiBEaXNjYXJkIG5leHQtaG9wIE1UVSBs
ZXNzIHRoYW4gbWluaW11bSBsaW5rIE1UVQ0KPiBmYzhiOWFkNDFiNDZlIGF0bTogY2xpcDogRml4
IHBvdGVudGlhbCBudWxsLXB0ci1kZXJlZiBpbiB0b19hdG1hcnBkKCkuDQo+IGE1MjdjN2FjNjA2
OGEgbXRrLXNkOiBGaXggYSBwYWdlZmF1bHQgaW4gZG1hX3VubWFwX3NnKCkgZm9yIG5vdCBwcmVw
YXJlZA0KPiBkYXRhDQo+IGRlYWVjMTA2YTM0NzcgY2VwaDogZml4IHBvc3NpYmxlIGludGVnZXIg
b3ZlcmZsb3cgaW4gY2VwaF96ZXJvX29iamVjdHMoKQ0KPiBkM2ZhYzE2MzgyM2I3IEhJRDogd2Fj
b206IGZpeCBrb2JqZWN0IHJlZmVyZW5jZSBjb3VudCBsZWFrDQo+IA0KSSByZXZpZXdlZCB0aGlz
IHVwZGF0ZSwgLCBhbmQgdGhlcmUgYXJlIG5vIGlzc3Vlcy4NCg0KQmVzdCByZWdhcmRzLA0KICBO
b2J1aGlybw0K



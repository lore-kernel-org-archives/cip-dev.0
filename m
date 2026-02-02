Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5521CD172AE
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 00:59:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42899.1769993990374607933
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Feb 2026 16:59:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=SCBhKPfV;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769993987;x=1771203587;bh=tLXujRiz5R51Y6nF9JpOk9EBavBhHdMYmT7Ma
	jGJuIc=;b=SCBhKPfV52E4+GIg+142MZhkJf09uwCvl/RvoX5TMnD8Gp8fZ2V7pHj4gkqnQEjlqCv
	oEZMpBRQnHTj6tYOTXVn2b4geNbwEP481LGIFD2xj+g8GPslYKGv5KseBfGRQiIGOv4MeNSwTz9jU
	hocHyHNYBI2CITYNdJdIn/qNsfKDcYqmkG9sABoFhIUujg5iJG+CPYVA6dHxDJdGBiXWhIVzt3OUK
	UBqX1Du4iW5cGutzQz+NpKzBTA2rSg7Co7EOcCz9QZctW3oTfbWXMTUDoMqcWIUMjcmNFh/D0igGb
	9smloy6KY/jQDk2YPanfyHa4Y6QXnnRlJMIppCHVVYzQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6120xliG3272896; Mon, 2 Feb 2026 09:59:47 +0900
X-Iguazu-Qid: 2yAbS7rJlYGGNuUh2i
X-Iguazu-QSIG: v=2; s=0; t=1769993987; q=2yAbS7rJlYGGNuUh2i; m=DY1bFyeEWCagEo80W7LUtIX+Oai5FriivpdHABoUk10=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f47Yv1BJ5z1xnZ; Mon,  2 Feb 2026 09:59:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY24XoUlPnSm9LDpjWWmybiDCfVWudSnblIXNEbP8peNd0+9re1gF3evlfQbCRJ3L0Bdz30jevhdlE6yiy57w0n7UkTuLp2pHFvKzQxVEvnbGxuOIgEL2Ilb06AszXVmswIU9L4wZE/wrH2bccutHcq962HxF5QC8jY5lcunirVs5zQXFaKeH/7qP83ZkgWPn9aTdtdaTCqUxsq5r2x810/G8Nw0szdWUudgSC9VCj2WJaMIPD7BbgJJcAauYNhpP1iRte+0F3xqicwy3+AlJctWGkupiuAPsYO2pJB2VbOpa3FJkOCH1WeOeiXqIdTRr93cqtx2QoiRyWpUlTebbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLXujRiz5R51Y6nF9JpOk9EBavBhHdMYmT7MajGJuIc=;
 b=aXksfTtiA8tW+2rua55TAhj5yef4kFYBRM2XjpYYpYvOTe2LhKgS7nMWP97sXsVfgQ6GMaWYH9orBfsAcnoyI9V5bdq4PEzaRqA6YZ9gJR4Iah7lcT0oUA1M4z4lYQ5khY0lhKJ1ARvP0KbsMXAZUiyr+yQBwxWobrO19vBz0fi/Wv8VsvPT4ZN8SvDyaJ1GciyzFCS+2HflqrF0lVYyjWPJ1UWlT4LeDa9zw1tDZuc/CyuWOCq6n5TNakjSYC1+SenHnGyFXnlHu5e5KK9Iis36FKZsAMy8xJ3FD/ojnI7XzR7019V0PE6AFMlXahAyztuaIWQkgvGvT1Ha0I7afA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <ovidiu.panait.rb@renesas.com>,
        <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Thread-Index: AQHckFXa9hMH3+Yj3UKPhR1dajP62bVoz38AgAXN9uA=
Date: Mon, 2 Feb 2026 00:59:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185E0DF03E70A896763DD8CD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
 <a1425ad5-8313-44f0-8ed6-af70be7e8e40@tuxon.dev>
In-Reply-To: <a1425ad5-8313-44f0-8ed6-af70be7e8e40@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSOPR01MB12251:EE_
x-ms-office365-filtering-correlation-id: fa8a6674-1b4b-45fa-0474-08de61f65a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VjJ5cFdpanVLTEZMdDhOUTB2bUNBVXd4aXJHRDRSc21UbkNNTW9TUWFIYnY1?=
 =?utf-8?B?NFdHaURlM21aUm8rRk52L2xkNzliNWJNc05aRDZicHFMMDJPQXVINGJnUWU4?=
 =?utf-8?B?aUliMC9QOGNPOGFQamZvS0ZkK2NlQjlPVVdqSWtwZk52clhodE5zVGI2Mm43?=
 =?utf-8?B?VEFlTHd0cEVadlFxcXNhd0dYZTJEVjd1YVF5ekR4ZWxHUUZsR29SSUxxWXE4?=
 =?utf-8?B?ak1GUHZBNVhjeC9BVmp1QUJzL2taREtjZDVDK1QvRUl2eE1kUVVyampyWHlG?=
 =?utf-8?B?YU9tZ0xBZVBlN0RSUHRPUVE1ZHV0blBJakUxeXV4NGYvaERpTmk2bUI2TTJG?=
 =?utf-8?B?cUl6WVdNdkxvU1RPL3dqSHo2cjF5dzN4bHoxc0l0OG5pZWJCQk1BTnBGWG10?=
 =?utf-8?B?MHdrVGUvZjhWclIwWHBuamh2ajkzcXNRY3JGQ2Jua0NkQVdiNHl5c1JLMnBq?=
 =?utf-8?B?WkpGeXNhaHVaeEVkMXZ2Vkc1YmpOMWJmVU9JYXVwWkwrMmpoaXQ1Y2RXMUZD?=
 =?utf-8?B?ZjdIb2gzSDRxajlPSkpvNlVmSm9JTUM2emtCOHBLMUNTc3drU3pKeHVRZlpx?=
 =?utf-8?B?d05qTk9Nc2xFSm9RWUhXWFlwMWVDNmVxckJNYVpodklYaXloYUh5OUl2blM5?=
 =?utf-8?B?dkkrSmRSeEljbVNIK1RTY2ZKTFNmcHJpZnMrem8rS2FLbWNxUFNOTjltd3F5?=
 =?utf-8?B?MFlleUtXeUp5Nml6UUxlWEpDWjltVmhZdUsvV25ZaDhabXpTVFp4UUVsTjBr?=
 =?utf-8?B?a01aMTRlcDB3RncydXN5S1p3QklBRm5QSmRtcGI4SWdMYmZZdUJxODlKQk1p?=
 =?utf-8?B?Vks4cm1SMFJQaEVUa0xTMHJYYnk5Yk1tOEp2UUl5TkVCMmMrT0V2c2lNWk4v?=
 =?utf-8?B?Z290RFJhWktnUXNzaTlYcGRzaHJnMkJvN1ovVTFYUk80NWhVSUlWOXlvMnlE?=
 =?utf-8?B?MlczeXZBUUdnSFNHcEE4UWd1bkFHWExpUmJEVlhIb040RkpPUmg3cy9mMk0w?=
 =?utf-8?B?eVVxUDJ2c1l3ZHF4MUFUOHNCQVJRaUtOc21wZWwzOGRRYW44SS9GY3pQOTRu?=
 =?utf-8?B?aFNkc0RjNmt4ZzMraFNoaEtRemdtdmtYY0dCTEdhcjdkOFZ1K1NscDBzMEZC?=
 =?utf-8?B?SUk3SjY2UVZMZFNPSFZwZ2U0R09WakRqcktFNDkyTm0rdkdUbDJuTDUvNEMy?=
 =?utf-8?B?SnRQZjQ2YUZlM3puREdCOTFScnovL25TTkg4Vlp1bFZ5RCszd2tOTUhoRDdX?=
 =?utf-8?B?OE83YjhRUVdlaWJqbHJTenVCUGlQMzBSdEFLUStIU1FIWDgraXpPRHloSUI4?=
 =?utf-8?B?ZXpNdHg0c05Qdm9pUTFqYmJRK0tKWmFGNEVPVmpONHovQ2ZTVkcxY0lYT2c4?=
 =?utf-8?B?UUlRaisxRGlJWGx1N3VxNnMxNGQzNC9TZkRvRGNpSFhkTEhoM1NBV0FSZ3ZP?=
 =?utf-8?B?dllmZ01VV2diQ01zdHVOZ0dNanl0U000SkhhQ0tKSEZ6aVRwZDA2ZGUvRXpp?=
 =?utf-8?B?YjRoTkNSZ1VpY2RIdjJuVkFNQjZjRWFxejkxSTFwaVFCV0FUME1kUnNBOWdR?=
 =?utf-8?B?WmFPRHROM2xVR25pQkkyY0x2YVNNYUZXRTJiOWRXRWovMHI4WEVzTDArRTd4?=
 =?utf-8?B?cG1VRVlCRm5CWTVPZ0N0SVhCK2pLbHZRWFZoYVd3UnlEVW54WnpDai92WmFt?=
 =?utf-8?B?d00rajNQOERZdUowakFXclhtMy81R2VhZndtWFRLVDF6NE1SNmh6ZDJOTTlV?=
 =?utf-8?B?dEpFaVZ4N3Q4b25sZFhSbDhBcFpCN1J1clVFQUp0MWQ1T2xITHRQalZ3TURo?=
 =?utf-8?B?ZTFGOXA3dkNiN3JSakFiQjZkd20yT3IrZGhTYnlhQ2VNRTQyWUFldEI4dEhr?=
 =?utf-8?B?LzFnbXh5L25QbUJRcTMxNU5rbDMzd3BMdlByekpHelhIVWFpZ0RUNUE0Wlha?=
 =?utf-8?B?a3Y3amdVU0JjOERjeUFLdTNUcXFkRFY2RksrcnFQLzNXd3duYTBTN0dUckIx?=
 =?utf-8?B?em95N3BtaFMwY0JwVkZuSUFMYmtUNFplQzNFSlBXNGZkaGhwZWFkQklJOUlE?=
 =?utf-8?B?MFR4Rys4Z25lRkNiM0RYbVd4VXF5TnZCaWRIVTBuYzMwU1ZhZnNoYURYckNt?=
 =?utf-8?B?U0NYeXlLaXdmN3J5bjYxVGVGWWp3dXJQODFhR01iOVFEcnBiZEQ3VG9FYmFm?=
 =?utf-8?Q?geEWEXz1nGoMRntEuVtwQpY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ODIyQ3JHeWFlSGRkL3V1YjN3TEI0ZzFoVzFxM3FLNXh4VXlHdk5YME4wZStT?=
 =?utf-8?B?ZGRDSEwvQ2Z6dGhOaWQwQzNJM2hKYUlER1M1VVdHN1JSWkYzbkoyWVhrMUgx?=
 =?utf-8?B?dHBwYXJOWEJvREJKMkYwWWhkamd1WnQ3dEtkNTZSNnEyMkowWjRzQ0hJRXlj?=
 =?utf-8?B?cGtZQzFpWFUvQ1o4Y20yaDJoblhwLzZiamxSdjNVdEpxeVozT0hBdDRRTmlC?=
 =?utf-8?B?L0FzUWErcXZ4VGtxMzd5OTJsSlVqNXRqaWxBcEZSbFhsUVBuKzZBU2Y5bTRr?=
 =?utf-8?B?cUJMQy9BdzhtTERTOEh0VlRmMlZmTnVja3BrTitDeWhMcW04Y1R6VUVTVjdT?=
 =?utf-8?B?YTlNd0h5aDZhd3hoNFo0U0h6UlVWVmpIVkpDdWwrNmk4OHJLMkJuN0JpWXVm?=
 =?utf-8?B?T0dFOTVIcmh2Q0Izdm9zOHA0RGVGQko1RlNCSFFuZFEvNU1qYm9ZbnB6T2lG?=
 =?utf-8?B?a0F0L3RldG9pWjUvdWhkckNVVTh3M0MvMFRZd3BVanRUOUFYQmRucysyRWpR?=
 =?utf-8?B?bThWejhJUVpURXVva0dwSmFjWkpVcUx2TGRoUDd4ZSt2b1dteG9tWm9aQkEz?=
 =?utf-8?B?QXlieUFPZExTN05LN25MeVFENlpHNTZlait1NVV5dlVVU2xCSzA4bVc3ZDRJ?=
 =?utf-8?B?bjVFV0F5SnpKWTNyU3hEWTZJcHJWTXdlS0QyY3FpdUh1cmNXajd6dnJDbkdz?=
 =?utf-8?B?QkdvWHRLMjIwUnBnT1JuTndaVGh5VG9rdTRCeWYzNVY0OHJWbUhlaVQ0dHhI?=
 =?utf-8?B?KzdDRkVqVnYvRElreWNoUmVKWUpNTU9acFlZSVppRkJLaWIvcUVOamtZd2sw?=
 =?utf-8?B?ckN0TTNUay9EeSs3YUl2bDVabzBhQ1pRY0JQM0xWZDB3ZFlyR1p4NVAxd1Uv?=
 =?utf-8?B?Yi9YWVpWemJLdmxHaE1VWjZqTWYvTUk3MEVaWHRnWkFzQThJb25Da3Z0YnVk?=
 =?utf-8?B?bVZkVXh0bGdxcEl0ZUsxWGEybUFsU1BXRmRuTmVjZ25BemhjK0prUXVMZVl3?=
 =?utf-8?B?NmpVcVkxazBrditqcHFIdVU3cE9pREFzMWxCbUE4bk1vM05USVorbHFKaWxt?=
 =?utf-8?B?eVZOZjhJQjNBSXpSaTZrdGpFazRMVHpyTHM5R2lmNWdoUmRuWExBamhTR3li?=
 =?utf-8?B?THdYcWRKMUk5QnZRUi9SUkhXVWtpQ0c1UVJBTEZzazhUWElQY3liQTR0K1Iv?=
 =?utf-8?B?eC9oaGRmVXdrcjBvVDg4R1hWTGFJU0RyRjc1VEhKelZxdXNEZEhRYUN4V2dV?=
 =?utf-8?B?UE15OVlCS3NCMG5xRmJKdnQ5L3FWV0pnTXdXdTlKQm5MOHlXRDNSaEJXK0M0?=
 =?utf-8?B?dzZGcDFNbEd3R3dVeUZ4a011a1EwTDBsSXdHSVkzaTJjNU5XeUs5OFNxWC9y?=
 =?utf-8?B?WTh6NEF3bm9aWS9LSVhDb0lRY1ZVWHMyMzMxb3h3SytMMGtScEc3WW1peG9C?=
 =?utf-8?B?Q1hsQzRvc0dSQTVjaDB0dnhiZUk1NDNqUnRwaUx2clpuQlViQ2ZvdmY3UnV3?=
 =?utf-8?B?Q3RJYWpobVBycDlDdGVNQ2RPUE9odHRWSWtEb0R2RnJ4NFg1TnRHV0dDM1Zu?=
 =?utf-8?B?ZmpPWER4NGJDNisyazZWR0lEbUJhUWdCVE1vcEJOZzFkK0VpSWlUWXZWd210?=
 =?utf-8?B?MEY5cm81WmswVFBGMjFNUk81QnZCOWlLNmppWGZwNUYrQnlUYlJEbzdSaXFt?=
 =?utf-8?B?VGhYRzloOGhLelA4TWJEaHArUTNNSEcyQ1lBN0tzMDRkWFFadm80QXREQlFa?=
 =?utf-8?B?L3dpMGxjQnVQTWdGV1BCV1E5VmZWaXNYSW9LRzRNcEtkZzRWQ1phT01sOFMz?=
 =?utf-8?B?bjFnMVhDZUMyZEx6ZFprOHhOQzVpaVlJWTZQZFp5QjlFeVhJNk83bGhFN1c1?=
 =?utf-8?B?eDNtbmpPV0Y3RFRpZXNOMjg2T1VjVGpGUVdUalRqNk81RVFwUWl3aUtsSXRh?=
 =?utf-8?B?VmJTN0ZxejI2TjRRSzJUT0wzNmNYaFFJY05DRjc5RkhxUHhJNXRrT3YxS3RU?=
 =?utf-8?B?RC9SKzhLVTVTY1Q0alNDeTFNbERDYVVjQ3RBYnVHUVRaY3dXNEM3SE95N3Z2?=
 =?utf-8?B?dFc5MnNBZm92cXdZamlYTkZscE9mQkhmYW84QmxyQ0lKajF6SnU1VkhVWk9i?=
 =?utf-8?B?N1g4SWViTlFzbkJNK3JxTXZxSWloajBvQ2M3SmpXaW1XSVFSdzlEcmVRM1Zq?=
 =?utf-8?B?VjNVRGFMTWI1bFpURFdVNjlEelBUR0RQOGRyb3N1OXROTWZSU2g1Y1FTNTNM?=
 =?utf-8?B?Q3FVSDFxZHVhRlg2bGZ0QkozTlFhUS9tRlVnQjBCaHM3cVJxUjJCZ3g2NUk3?=
 =?utf-8?B?YjFEUFNmUmVXQldUZEx0KzIxWFRKQmt2RThGNFZyeXBrUGVnc1RFdEZZZHRh?=
 =?utf-8?Q?slob4+guakvec+zw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8a6674-1b4b-45fa-0474-08de61f65a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 00:59:44.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrlASuHmjhViE96hQE0Txw3/UpJlEXin+xoTL/LabbtYH1Zc2w1DKGKdZJA8MGfyxeC8hHUMrqBclnrQqFz1/zpakveZWiEwhpPABsEmtf2r1rvZ+ibwujJnLXlTlOv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 00:59:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21792

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51
YXJ5IDI5LCAyMDI2IDU6MjAgUE0NCj4gVG86IG92aWRpdS5wYW5haXQucmJAcmVuZXNhcy5jb207
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOw0KPiBwYXZlbEBuYWJsYWRldi5jb207IGl3
YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0
KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gU3ViamVjdDogUmU6
IFtjaXAtZGV2XSBbUEFUQ0ggNi4xLnktY2lwXSB0aGVybWFsL2RyaXZlcnMvcmVuZXNhcy9yemcz
czogRml4DQo+IGludmVydGVkIHJlc2V0IGxvZ2ljIGluIGRldm0gY2xlYW51cA0KPiANCj4gSGks
IE92aWRpdSwNCj4gDQo+IE9uIDEvMjgvMjYgMTQ6NTgsIE92aWRpdSBQYW5haXQgdmlhIGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZyB3cm90ZToNCj4gPiBUaGUgZGV2bSByZXNldCBjYWxsYmFjayB0aGF0
IHNob3VsZCB1bmRvIHRoZSByZXNldF9jb250cm9sX2RlYXNzZXJ0KCkNCj4gPiBkb25lIGR1cmlu
ZyBwcm9iZSBpcyBpbmNvcnJlY3RseSBjYWxsaW5nIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoKQ0K
PiA+IGFnYWluLCBpbnN0ZWFkIG9mIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KCkuDQo+ID4NCj4gPiBG
aXggdGhpcyBieSBjYWxsaW5nIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KCkgYW5kIHJlbmFtZSB0aGUg
Y2FsbGJhY2sNCj4gPiBmdW5jdGlvbiBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IEZpeGVzOiA4YjUz
YjBiZjEwYTMgKCJ0aGVybWFsL2RyaXZlcnMvcmVuZXNhcy9yemczczogQWRkIHRoZXJtYWwNCj4g
PiBkcml2ZXIgZm9yIHRoZSBSZW5lc2FzIFJaL0czUyBTb0MiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6
IE92aWRpdSBQYW5haXQgPG92aWRpdS5wYW5haXQucmJAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFu
ayB5b3UgZm9yIGZpeGluZyB0aGlzIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVh
IDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCg0KQXBwbGllZCB0aGlzIHBhdGNo
IGFuZCA1LjAueS1jaXAsIHRoYW5rcy4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K



Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDADEC44500
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 22:11:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24113.1769033498011021818
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 14:11:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=apvG0gsv;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769033487;x=1770243087;bh=hC6a0iHBIZdsVbaczbfPz2YvwJSymixdPSXjm
	Q/XpKs=;b=apvG0gsvBqH7iJB1t0C8ELk+LY3ZVSdtRracfIqRx4hH2UtpKi97VLYWa8VeGfVSbME
	8VqhyTbadijWBRK17yFHrKskwbNAnyJyxX57SvkGEPqQj6K89B56pHT1FDv95aPN/GNRTHymdfE6c
	69KGF6Pdg2BBm9h6lKbuL7C0vmTCW5W08B8gqK+tsgvF43bcwSXuqIFGGPbPVAuGeyjCLL5Id+sgt
	BxXygtHJU9e+oEdjVD2NAm79d5WCSHCKSKDcA8zGXtdYCCdGyCU+tykiBmzN2V4x3HNPJjnYklmZU
	VySWOIimNtHjpYzmcrPz51ZZmLcbfTJsQGtJ5rgYlvCQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60LMBQsI222602; Thu, 22 Jan 2026 07:11:26 +0900
X-Iguazu-Qid: 2rWhoMOwvIXDsW1uPQ
X-Iguazu-QSIG: v=2; s=0; t=1769033486; q=2rWhoMOwvIXDsW1uPQ; m=ShRhopFwNr8aJQCizT/TXrcOvIPcb4JJ96lkuT86zJk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dxJLj3s9Rz1xnZ; Thu, 22 Jan 2026 07:11:25 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuvGtoL9IfAUHEdCUbFDfxtlO930a51O+TIb2XZUKMIhLZhwKAmCjTjfkV4Fg/0YeDi7fn+DyR/apAcV3LW8QrmEjPW4IvYy/aC6cnKXqb1cjQqekeSSmvRDkHuMwso6BKBq9EiIZq22gAOzuPQvgteP4QbkLBPARJR+vcODiQ9WvxEXN9DLO9HVJrNiqn3e/zbHVMUUmE+8zqVO3Z+/OIBkOEoINIrqjNSvvxoT8n4IxN3B23UX+Hk79q9agDoqZg2V0G94wrRFLvTplKg5lmyzS1UlUeWVil9boDtPtintjr+HwnZIZLoArVs6XpzWT1CrL0o2528A3D0y1SoR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3jAhvo4893WccV7Rzs61h1LuJuHssX67oza2rQ/Dls=;
 b=fsymQeKCXSsZ9Rg1Yu98KqU5+nFqy5e2gxjTKWRANv0G8is0GiJ8Kwyc9kn5XWkTatXaiSANcdkVDg6yLgFPnV3+yEyyN5mPadM/aS4r4F0FLVL1RATSwebXTxi9wXkRMv2iRVpREXIhWE9zJ/tjgBznk5DiqNlwPvkaJAWtNc6RXL53ZUU/HVqXiuUH02u/nHk5KaQt3Jp6ClkYW3hWQ1JVoF2OUki8xGMMItLVDNWpaACJM1b3mSiIxouC+3glfXjj9I0Ao6xJ7pOT6ecGZod7Wk/EeNlwDq8MY11wSE4D0+OYVyyyjvmxltFXhEnCUZk5lcGo+AcpVpjQEF7NmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>
Subject: RE: [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}:
 Backport MSTOP support
Thread-Topic: [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five,
 V2L}: Backport MSTOP support
Thread-Index: AQHchfoG5Wgk7wry2UmSC2IVMllIgbVdOHQQ
Date: Wed, 21 Jan 2026 22:11:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D6D14659F1C91CFE03BDCD96A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB17271:EE_
x-ms-office365-filtering-correlation-id: 49eb9795-061b-4d47-be53-08de593a0336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cmVzdyswcUJJck9RMW8zam01MHUxeHllTWlCdXdyRGZZUWNiOWdrdCt2?=
 =?iso-2022-jp?B?dnZYMStlRHlObENCMk9BU25Jb20xMDJYeG9GeFlQOUVMOWlpTlVZU1Rl?=
 =?iso-2022-jp?B?eHFvVWE5Um5va1RTWUdLcFBoQjMyVG9UY2JybUpESzloM2FWWDBGMXlq?=
 =?iso-2022-jp?B?N2FLa2pkNjdvRCtJbEFJRUhXQlNqVUc3VHB1cDJNdUd2TTBPSnBQWlVj?=
 =?iso-2022-jp?B?aE9IdTZnME5zbWxncUU3Z2ZqSHNsSnBiSEZ1cHNKbUpQdlNRdUYzSWpK?=
 =?iso-2022-jp?B?QzBZVnYvV0VMWjRHTmJzRDNKYWtqS2N6RERVQ3VMS2wvK1dPMjUrUG1J?=
 =?iso-2022-jp?B?N0tEMXJHQmxoR1NiaVNWbGlWWlRqM28yS2JKZGI4eUJhQXFQTzBPaDdh?=
 =?iso-2022-jp?B?T3dKWkZ6Ky9qeDByQzhicjlINjlFTEJjUjc5cytvVDJSeS9UajhBb29Q?=
 =?iso-2022-jp?B?SmNJRGF0cXNBenVab29DZDRFS0hSWnpVZVlKRGcwZmJic213L1VZRTNw?=
 =?iso-2022-jp?B?TmVpNE1pZWFUSjdBN2JMSkpWcFdwQ1FVbnlqSllJVjVGTDhFTEN2MkRQ?=
 =?iso-2022-jp?B?R0FITkQ4YVo0RWdxR1FWZGt4ZGUwZkgvTGNQUUtIdk1ZbkE3REc4SGJS?=
 =?iso-2022-jp?B?QTdTZFo2dVNzR1NxckhnRW9oMk1yOERqdS9mQmhJMDd4Q1ZRMFJ6dU5I?=
 =?iso-2022-jp?B?VnFwUlJNUytjTkk4QXljbzdId044WGlLVy94b3NQc2U1MDBQSGlUVHY3?=
 =?iso-2022-jp?B?NlM0R1NwT3pXZlFDbmNZQlVScUY4OEF6SDNRZm1yQXdZbmlwdEh4a0hi?=
 =?iso-2022-jp?B?Si9TdksvbzNuTmMraHJTK0Y5aXB3VkFLRHhYM20zZ3dwWjRjaXMxOC9E?=
 =?iso-2022-jp?B?aGtTL29xYnJlNGFwWHJTTHF6Y0J4VzJ5VUVkWjBadzBKbXVBUVFJVFZE?=
 =?iso-2022-jp?B?UENpcTdWSk9rMGxQM0pBOXJPUE1ZWnozcWE1SXgvMXJGTjBzL0VDbElu?=
 =?iso-2022-jp?B?NXhjTmkrV0JOaDZqMWYydWhsaStTV0NLS2t6QlBpQjNkWWVZL2NnV2ll?=
 =?iso-2022-jp?B?ZTh5QnVRZjFNNVppYWpRM29ya3dwdHpQRk5LRkxOYzY0ZnN4bGloYy8w?=
 =?iso-2022-jp?B?NHJoVmNQb1VwK21Nc01sbzN3bW85bnVsNk96WjZGOWdoVno2b1ljVS9y?=
 =?iso-2022-jp?B?MUV3M3piNEUrTnJINWpsMUhUOFNZc3U2Nnc4Mi94MjZxdnhESXlpa1J3?=
 =?iso-2022-jp?B?d1l0aCsrYWVJaXIxRG4rV0ErY21jek9lbUZ3a0VPUW5CTFc2YzZiVldF?=
 =?iso-2022-jp?B?d3NaNzhETXRIbUxraENJUXp5Z1dDdUVnYUhIZ1VXSGczRS9aNGtSVDBj?=
 =?iso-2022-jp?B?ZjJMKzMzQlRjanRhdTBKbm00WTAzL2pPa2xnWkNDclMwNDE4Zmh6KzFo?=
 =?iso-2022-jp?B?OERnUk1IWVBzRmFIOUtPbmtTTXJwM1pmallvUDZadTZDeHBQQTZKbXlG?=
 =?iso-2022-jp?B?b2R5dnl2VFFVU2VGV1BOb241SUdwNkZHM2FjYW9aendlVUMrTU9iMmtp?=
 =?iso-2022-jp?B?dkxTcVVOd0cwR0Vjd2NEQlRNazJMWEorK1ErNWZibFg4R1pDWVRZa2tD?=
 =?iso-2022-jp?B?dDhtNFYvRUdyRkQvQnJhVURUbHBlblkwSVhVemtoa3Y4UG04ZlRrd0E4?=
 =?iso-2022-jp?B?M3FrME9wVXZyeFNrVE1wZWlaVGRiN1pHOUt1SWVUclBjRmVnUmlrQ0Va?=
 =?iso-2022-jp?B?Y3loWG5aUkt1elFqa1V3YUN4SlBKOHE5dW5TZk5HUjJ5bHlBSjZuRHA0?=
 =?iso-2022-jp?B?MFBOMGNXeHVSWmwvSDdPSkN5alQvcWRNdlRvQmZiQXlCQXErV3hFYVFp?=
 =?iso-2022-jp?B?YTRMR05Ca1hSQ1UxTUVBRytyUDhacG1UZTdRNm81RUdzcDEzL1NGbXV0?=
 =?iso-2022-jp?B?Nk16dldKNHBzOWJ1REo0U01YaktsTm0xVTJkRWljNUxheXQvSlZEN2dk?=
 =?iso-2022-jp?B?dU5YVGFQRi9UYkJGY2VhTGRGcWhFeEVWak9TWlBXTXFGczJSYVRtZnB6?=
 =?iso-2022-jp?B?ZHpHWkYrOHJ6b3lTR1Nvdk9wN1hNeWR0Q0hYZUwydnB0QlNWMGppc2gy?=
 =?iso-2022-jp?B?OTlGaC9mQk1GRmg0dGZwaUxmZ0lzeXdySUJiUFhpVXZEM0t1SUZrTGpt?=
 =?iso-2022-jp?B?WFpjMEhkRlZvVDEzZmZWeWJmQ0RMUW4wWSs5NjhkUHQvVHdYMmt4bG1X?=
 =?iso-2022-jp?B?SFBZRGlHclI1TnNkekpiZkN3dEtjeHI5Q0FRZDZzbm5Ua0xveE01Lzkv?=
 =?iso-2022-jp?B?UTIzdFEzc2tjeGNkbEg0NmdXdTcwRGQwR0FhOFJGRVpFOFByZVJFVGVS?=
 =?iso-2022-jp?B?ZDVVeG89?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cTZzL29SVkJUS0RxN1RHNmJFK0l0ZXBvKy9vcStoRXpYSUZIbmVwQm9h?=
 =?iso-2022-jp?B?ZWdRZFJqRGZTNURUUHZ2dVNmblgxYkJEOHhFdWpuaThVekJ5azNVMzBk?=
 =?iso-2022-jp?B?SC96cjQ5aFVwUTVZSXJhanpRZVdIU0NtV2dCZkdvKzNhZ1RSVUx3aWhh?=
 =?iso-2022-jp?B?U3ZIcDNBcGZzcDJmVTNCaGhvMzJNdUNuVE1rZGU4YzA4Sk1WanFXUlIy?=
 =?iso-2022-jp?B?b0UyNXkwOG9URGpTYTE2dzlBbVdndEtLb3pia25EMmRrY0hMeFdCRG1n?=
 =?iso-2022-jp?B?bk1BOXlWMTl4MFYwUlZvUDgzblFNMnFPekhlNVg3WXBlWlduNlIxbnJs?=
 =?iso-2022-jp?B?T3JaWnRBNUNIQTRuYm8vZTBReFVhanV5bGd5YXB3L3VnbjNqTTZRczJx?=
 =?iso-2022-jp?B?ZkdzY1lsQVpSa1ZmU3ZhM2JVbUp0aFcwSWRPYmZnVXRJUW5sbEdOSHlG?=
 =?iso-2022-jp?B?N25qd3hrT3h1ZWZNRDc3TWNKQnVVQkNyalJRVUF1WWNqVitxYmJxbWIy?=
 =?iso-2022-jp?B?V2FvQ0s4UytkbkRvMlpoazhZbjAxYjNrdklXWmM5TTZiaUhiTFk5c3h4?=
 =?iso-2022-jp?B?aWoxdzdkT280bmgyRHlZK3ZqVldLTEF5dVRmSVJ6blRTbTJjekVXcVZE?=
 =?iso-2022-jp?B?aVpMVjRrUlVZN3l5Qkl4eXhxSUxoQzMyL2NhRFV3NTU1OWhCTkY5R0Mr?=
 =?iso-2022-jp?B?L2VIV1Q4US9xbDc2dWRJQklHZ21oby9NV3J3a1ZKQjB4NlltN2J2Ym1k?=
 =?iso-2022-jp?B?Um16MFU3cGoxV2pSLzIwbzcvN3dFUjNialRuUjdNVnAycTZpZ2hxTGgz?=
 =?iso-2022-jp?B?dkhhTVlwSVVMd1k5aWRaUERWQmZsRkg3dnZwbjkyTzcvakdpWElLa3JW?=
 =?iso-2022-jp?B?YmRudjdtTDdQOGYwbXlHZENocVFxdnQrUzFnYTZadko1M0VKOXFOd0dt?=
 =?iso-2022-jp?B?NWxCTHp6cndZcm1yemZTRnpiRytWcDdCamM1WlFlOFZ2OWd1OVlPanNH?=
 =?iso-2022-jp?B?R1FZSG1xN0FhYmh4V0p2anRQcVJnd1IvUkY0VHpZdWtQWnpQYklEMlNR?=
 =?iso-2022-jp?B?NDZDdUFhcWZQWXBBbzB4OThCRWxRanJRY25yK0NLeU9BdEhHclRrRk1t?=
 =?iso-2022-jp?B?TGFRYUFNVXgwVS9WdGZ0S1VHZkJ5a1Noa3NDZi9zYUFUS2Z1YjFyUUE3?=
 =?iso-2022-jp?B?K2NKbmNaOWZyRzUwMVlZTXhHdEk2RDNEaStLWU8vWkN3N2V0QVFlcnJP?=
 =?iso-2022-jp?B?Y05uWVJ1V29rYzFjU0x6SlljVnJrMWVabnhuVVdoMWhGc0Z1UjMxT1dV?=
 =?iso-2022-jp?B?cHlOMHR4YW12aHBVaUxuSUxvU056VmoxQTVadWxYWWJjMnZ4Z2p5ZnF1?=
 =?iso-2022-jp?B?WXhlUlNXQW5yeGZuOXdEY1ZWaERmcTFMQmd5NTZNTGwzQm0yMW9PYkh2?=
 =?iso-2022-jp?B?eUFLQW54bDU0enRhVnJOVWx1ZnBmVFV4azA4QjJVM1JCZ1dNaGp2L2ls?=
 =?iso-2022-jp?B?SGdLY0tKSW1CdUxSTkYrWnpsdWZDRXJVQUtqOUNUNkRHQzFTaWl1OElo?=
 =?iso-2022-jp?B?STF5cVpWYWFHN1hrS1J2SXJyK01UeGVxSG9QTS8vY3lRWVZySlhmK2gw?=
 =?iso-2022-jp?B?eEtZMmlJN1BYZVFxRHpRRmxwL1dJa1paSzU5MGFSYlI1QjJnOWNBLzl5?=
 =?iso-2022-jp?B?NURWd1c2WlFoODV0K1J6dE05WmVqWmVJK29WVmtBL0hKcGhSdERnSXdZ?=
 =?iso-2022-jp?B?K0NPR3VWMzZ6N1JyU0h1V1ZhTDdCZWRQNEhia0Rpc0lXU2FiWUxkSitK?=
 =?iso-2022-jp?B?bUxhUnRwYnRtRTJRdExJK25oajBrWjYxeDZJMjVNRzBuWEwrTUh0VllL?=
 =?iso-2022-jp?B?b20rZ3VjdlJLajBaR3QyTFdQY0UrZ296RWhyb1BKN2dJMmZIOWxiV2dt?=
 =?iso-2022-jp?B?aUNPR2JBVW9Gb1h4US9DRjA3R2xnM0JTUmUvMSswVWcyU1ZDZXNGaGlP?=
 =?iso-2022-jp?B?elV1dHRSU3liVmR1Q1V2REptQXVXWGpCM1hWa0pqL3dwbTArbE1xNjRP?=
 =?iso-2022-jp?B?VWpGVUthY0pDQitVOHU2cnZ0SUJuR25LMDUzd3h5ZzhtWjNvZkQ5Zkw2?=
 =?iso-2022-jp?B?MlF2OFRVVjQ4cDFsN29jRFFRU1NaTndWSU9DblhTNFJFb1lod1JOM3po?=
 =?iso-2022-jp?B?L0tqQzRrWUpCeEdlU01uTGRNaXZHb2pJbExVMHA3akdHMmNpTnQ4VlQr?=
 =?iso-2022-jp?B?Q2F5N25UVFBZanQ2a2hTb0k3TFdVWE1vMnRZYlhvY2E2SEUveXlQOXBh?=
 =?iso-2022-jp?B?d05aRUNueGt1dWlhY2tjajlMTHFUZGd2VWZmOGFWWW5PZkRaaEJjVGdt?=
 =?iso-2022-jp?B?UWNVbXRBM1JKdnhMUnd3amNXTU1nUjJSZUNDazI2V1BaREREelNPSVl5?=
 =?iso-2022-jp?B?QmtnSjFhMk8vR0FQS3prcDM2bU55UkdYTlovTVV5ekUwR1hlRzBRQzdL?=
 =?iso-2022-jp?B?a05JMTB6Ny9SSzJmOUdWUXpJUE5Nem9HSmNteTRkR2c2d1dnaGttWk1q?=
 =?iso-2022-jp?B?U3Y3MjJOND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eb9795-061b-4d47-be53-08de593a0336
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 22:11:22.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCjdnfxneRtueUS8d1WmYClTHIZyrJfwS7rniIpzQpBVtE+SgU60egYlp8GaFYJPNZrxsjTNiHoZHYvg6QFRGVbKOaW31bQ+VVCcKAHRUJ2RruLzpvz0fzGn02cbHcOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17271
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 22:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21692

Hi all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Thursday, January 15, 2026 5:36 PM
> To: pavel@nabladev.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}=
:
> Backport MSTOP support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the MSTOP (Module Stop) support for the Renesas RZ/G2L,
> RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> The purpose of MSTOP is to reduce power consumption by stopping
> unnecessary module's functions.
>=20
> If any master accesses a module that has the clock stopped and the MSTOP =
bit
> set, a bus error will occur.
>=20
> Due to this, to avoid CPU generating synchronous aborts, changes to PM
> domain specific code were needed. The changes backported in this series
> were adjusted to be executed only for the above mentioned Renesas SoCs.
>=20
> Please share your thoughts on this approach.

Thanks for update this series. And Sorry for the late review. The v3 is oka=
y change for me.
Other kernel versions seem to be fine too.

Reviewed by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

>=20
> Thank you,
> Claudiu
>=20
> Changes in v3:
> - kept RZ/G3S TSU clock as it is now integrated in v6.12 CIP
>=20
> Changes in v2:
> - dropped patches:
> -- rpmsg: core: Drop dev_pm_domain_detach() call
> -- soundwire: bus: Drop dev_pm_domain_detach() call
> -- serdev: Drop dev_pm_domain_detach() call
> -- clk: renesas: r9a07g04[34]: Use tabs instead of spaces
>=20
> Claudiu Beznea (19):
>   PM: domains: Add flags to specify power on attach/detach
>   PM: domains: Add helper to check for PM domain detach on unbind
>     cleanup
>   PM: domains: Detach on device_unbind_cleanup()
>   driver core: platform: Drop dev_pm_domain_detach() call
>   mmc: sdio: Drop dev_pm_domain_detach() call
>   spi: Drop dev_pm_domain_detach() call
>   driver core: auxiliary bus: Drop dev_pm_domain_detach() call
>   i2c: core: Drop dev_pm_domain_detach() call
>   clk: renesas: rzg2l: Move pointers after hw member
>   clk: renesas: rzg2l: Add macro to loop through module clocks
>   clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable API
>   clk: renesas: r9a08g045: Drop power domain instantiation
>   clk: renesas: rzg2l: Drop MSTOP based power domain support
>   dt-bindings: clock: rzg2l: Drop power domain IDs
>   Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update
>     #power-domain-cells =3D <1> for RZ/G3S"
>   clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
>   clk: renesas: r9a08g045: Add MSTOP for GPIO
>   clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
>   clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
>=20
>  .../bindings/clock/renesas,rzg2l-cpg.yaml     |  18 +-
>  drivers/amba/bus.c                            |   4 +-
>  drivers/base/auxiliary.c                      |   8 +-
>  drivers/base/dd.c                             |   3 +
>  drivers/base/platform.c                       |   8 +-
>  drivers/base/power/common.c                   |  29 +-
>  drivers/clk/qcom/apcs-sdx55.c                 |   2 +-
>  drivers/clk/renesas/r9a07g043-cpg.c           | 132 ++---
>  drivers/clk/renesas/r9a07g044-cpg.c           | 168 +++----
>  drivers/clk/renesas/r9a08g045-cpg.c           | 252 ++++------
>  drivers/clk/renesas/r9a09g011-cpg.c           | 116 ++---
>  drivers/clk/renesas/rzg2l-cpg.c               | 476 ++++++++++--------
>  drivers/clk/renesas/rzg2l-cpg.h               |  71 +--
>  drivers/gpu/drm/display/drm_dp_aux_bus.c      |   2 +-
>  drivers/i2c/i2c-core-base.c                   |   9 +-
>  drivers/mmc/core/sdio_bus.c                   |   8 +-
>  drivers/rpmsg/rpmsg_core.c                    |   2 +-
>  drivers/soundwire/bus_type.c                  |   2 +-
>  drivers/spi/spi.c                             |   8 +-
>  drivers/tty/serdev/core.c                     |   2 +-
>  include/dt-bindings/clock/r9a07g043-cpg.h     |  53 --
>  include/dt-bindings/clock/r9a07g044-cpg.h     |  58 ---
>  include/dt-bindings/clock/r9a07g054-cpg.h     |  58 ---
>  include/dt-bindings/clock/r9a08g045-cpg.h     |  70 ---
>  include/linux/pm.h                            |   1 +
>  include/linux/pm_domain.h                     |  15 +-
>  26 files changed, 673 insertions(+), 902 deletions(-)
>=20
> --
> 2.43.0




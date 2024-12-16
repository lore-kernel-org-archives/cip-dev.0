Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04846E77180
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 07:03:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.51179.1734332607267981862
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Dec 2024 23:03:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=frmWkMAs;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:MIME-Version;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1734332604;x=1735542204;bh=VQdYM
	1kzMeROjmBE1LXB7mPvQAsXug2ZnrcOGi5V1TY=;b=frmWkMAsVILY4NClxj1gfxb/7gH7/o9PnHs
	UfSJlro0Nws8WdVKwzjA7Rq8E+tZyWYQWJe6/s+GZv+fILS6a2GzadziQE1n9Q0zpt9B7EZwq/9fe
	R0xrDyEFm+foottto7Hpdmf8VS2KJWlcoa2M12+DrEaayVnWRTOmSVEz8FYceOGbyxGKFwa1W6e43
	OEZbBDF2UrzUOCyTzI3DmeHYO72BVRG0bOhpezl4y7II7EOfX+AAlfrhFEXTlzzCPJTCacUbgGm5T
	SFVVuwpFIBfMs0dOKkQEAPHEUHIHGHQT46RvZDSbXi+ir9zBHOIloRoN9UehPnPZ5ygfRVtnmd9Q=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4BG73OqW3219883; Mon, 16 Dec 2024 16:03:24 +0900
X-Iguazu-Qid: 2rWhSHZE2RiiZ9JXnI
X-Iguazu-QSIG: v=2; s=0; t=1734332603; q=2rWhSHZE2RiiZ9JXnI; m=ImSCBOZXRWzeRQArQRON1GCjylmgx+nxYEPQbRR3ZhM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 4BG73MKM165799
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:03:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSTzv9yMNvEvOte/rZxXIUbll39aHG8lwPBaEWc6ocYtb2vG9ocm3aUNDzy85S/U1eowT5/VW4LuY6hYcpK0tPlGFuLfnA0dTt6FKmL9H6Ee4fQUTCQqpJAdBPxC3dOp4j/1SnpcuXoEsclnHT0h+9PTaI4HqWMuUX3sqqbjJtmC+kptxS9P1di/Ao6ZOTAw3ANmwCHKmcQUM3oauiACK6vwoB0bQuiYr6JG11jzcR6J8QuIgefKlgFzKl58IRtt35beSis0Nq3bm/sW98tq2J4GKGs4thq6iQ5INyS56wCUjHTkLrSISXbeYwGDu4+v3OXX8HOtfvKBuIZ5Kczi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o95VL3H0ZGDpooelSapx9VWh/tgcZIueDyDnBPrH7Wc=;
 b=bdywfh40ApD2h8laWbV22w6T/qjevMbwM8KvJolKOW7EN+RNiwPIdAcspfxBHmMssCEEgbzM4ss4QJT38b4/0qcjfzuJvGbYMbbpLBqT3+sOBQY9rRyNw3+/SgOuWIvFZQ6NoT8HQWLOPjBwnT3Uc2YsHY2PCQuukZn3tkWAaVRKK5ds4x6IblY1rYbNPx4JeKw76pwGsnZsoKE5JuAnVZ9f5++92VLiN+R2bmClu/H2D6FNbuFT8Cepy2L+OFe2NoZfToDBbqelM9zdEghFPQX2uhoQqtJdn6B9GMavhtNbgwDPgy7S8KktapXc0/7izbzf+OX6ut07uoKqRs5NTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaAAkRe6gA==
Date: Mon, 16 Dec 2024 07:03:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz> <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz> <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
In-Reply-To: <1810B3A8127ABE18.31077@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYWPR01MB11018:EE_
x-ms-office365-filtering-correlation-id: ac43657f-cbb5-4570-5fab-08dd1d9fb97c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b2hHbXBlRDc3WHZWVDRLaC80a0NrRHdFRkQzQnd0MXFVcTFXMElidUk0?=
 =?iso-2022-jp?B?cmtzNWN5Y2wxakFTUkUwei9ONWs4am9zOHd3cEVoRmZZT1ZQSkhydDla?=
 =?iso-2022-jp?B?UU1Sb1pqeWtHajNJVDMvZWFSSUg2bkhham5QLy8zNy9OL1NWcXNDcXNo?=
 =?iso-2022-jp?B?WUF1SE02RnNyd2tBL1BrdXhPSkR5c1hQcXVmeW5DWWUzd01SLy8rR0do?=
 =?iso-2022-jp?B?eE1hWWcvbnpZcHNQQTdyOWZRTXFScFdkRm1tMGV1KzZpbDVuc1lMSHFY?=
 =?iso-2022-jp?B?eE94U0ZSSVdIV1Y3NEtEdEVGN2xSbjNBTmVBRFhydnpTOXRneklDQm54?=
 =?iso-2022-jp?B?YnNDY0lrNWcrOXl3NGY4anNKWjZOeTJkTFZQMWJ2OTRhOFY3UlFBMWdZ?=
 =?iso-2022-jp?B?bXVkeVFJZ0hCQ2l0Vmt0UlBPSVBTUUJWSTN6eVpmdWVKU2thRXY2ZzlW?=
 =?iso-2022-jp?B?SWZxeUUvMEhWYkwyVnBHUUJBTmpqZFlVQzN2Q3AyVmh2ay8vaVdWOWp2?=
 =?iso-2022-jp?B?WDJibk9tT2lTbkhUOUMyclhsazcwWDZudzVVOE5hRW5XaW5EUkFrSUtC?=
 =?iso-2022-jp?B?blVXZG80bVJxTktHY0RKcEdOLzRkRzlwNHdVakU1cGUyS1Zlc29kTlJR?=
 =?iso-2022-jp?B?LzFlR3Y1L1F1RlVIdXVCSnJDWHhUTlBxTm1yWXdhK2ZKU0U0TE5VNTFX?=
 =?iso-2022-jp?B?UU1JRG5udGFVMVVDNStYRWZNTWlEZHRWRVV3eEQyeDVwK3g0QnVoRTRS?=
 =?iso-2022-jp?B?RE40RlRlaHRWSmRiY2Q2NUVSbzBjUlY5eVo0WXRpbHQwdktFK2lScThk?=
 =?iso-2022-jp?B?ZE5BcG00bzVPc3ZhcWVHNzZ2WXFPS0ludUxqR3d6MnJNUUVjZFBON2Nw?=
 =?iso-2022-jp?B?dGpEV0hTSFZzb3lqZEVZdEgxd0JjZm5pQTkrMlpycnUrcjVwZkUyQ3NZ?=
 =?iso-2022-jp?B?OXBUcm04cmFxT3hHR01lNFJXODlWaE1zRS9OL3dyejlxSFhWWG5QVzBa?=
 =?iso-2022-jp?B?MW5aOXMveWdzL1ovN1Nhak1uN3Q2NnpEQXJsbEFiT0VoR1BiVGFGTmtO?=
 =?iso-2022-jp?B?UEFoRk8ybENIS2d3MnBGVUpuUlF4RnMrSGtZWjd1NGl5VTdHanRBRjJn?=
 =?iso-2022-jp?B?dzk4RzZmWGVzUUFQWVlqbThtZWdoQ2FkNkNreXc4YWJXeVpnWHZ5dFZi?=
 =?iso-2022-jp?B?SEZrbFdVb0FkWHQwN3NiTXYxa0E4Y3RGSDFkbDJobHpXYmRJUWMraCs1?=
 =?iso-2022-jp?B?Z1lRYzA1UWlNem1oaWFwZlJDeVJHVHZyQlZhRHEySm5xYVg3QXlSeG1o?=
 =?iso-2022-jp?B?ay9mUHpzeGRHTG16bnp5dmlsZnlGL1hqYVc0OU9xYXJPNmhGajh4bTkz?=
 =?iso-2022-jp?B?UGcxdWFSK0NQQ1BMdTdOd01PRHZqU1dSeUZXN09XWUlDeUFxR200N09V?=
 =?iso-2022-jp?B?RndocFRuVE9XTGhuVkN3bG42VTg0ZTd2T1pwem5YYTM3b2JwVTdtdk5Q?=
 =?iso-2022-jp?B?ZGFML0lxUVJnRi9JSk9zMGtNUlU2bEMzNzFaa1lsbmdLSWRiWE12NjR0?=
 =?iso-2022-jp?B?NTZrR3RRLzFJWnZUM0ZFRW5kU25qL2srcVFyNnF1a01xTDMyOWZWbDJE?=
 =?iso-2022-jp?B?NkkzQndjcFY5YVQzV0RrbTQrN0U5RG5sNitrWi9jZlY2OXZicm1FTjFt?=
 =?iso-2022-jp?B?c2xhd2x4MkQrVUh5Z3Q3dVNiMXV6UVF2Y3dhYlQ5MEVYZXZTRUNad1BS?=
 =?iso-2022-jp?B?bStTMGZQdDN5NC9OeGJMY0ZBaHpEaEkwYlg2K3hRL2FFWFdyOFF2Umcy?=
 =?iso-2022-jp?B?RWpOQmQ1ZU1GYzBKN09YRnlwVEdYakxCRTlBSGx3N2dMcFZQT2RtdnN4?=
 =?iso-2022-jp?B?S1JubEEwa21GWFYxMXhwc1dPZm0rU1MxNzMwMy9lUEJBcVpSdlZraWo3?=
 =?iso-2022-jp?B?WWN4aktWSWtuV1l6OFVrUGR4RGZDMkVYajJiVHUzM3NqcklORXVFemQ4?=
 =?iso-2022-jp?B?VTd6aVl1Tkgvdm9QN241cXg3WVJQcnpXQ2dTS2p4TVZDNko5TU5JQnRW?=
 =?iso-2022-jp?B?NHFHU2RDdG1zTkgvdW1SSURZeFQyd1NOSDJqK3RuS3FsSGxWdjNxa2Rq?=
 =?iso-2022-jp?B?Wjc1Nm1GRHY5VVV6RUlwZkhBQ0Nqc1VRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YUFwYXg2UlNRRDhEbG80SlYySWxZRTZKREljR0NtdkdZV0FsV0VvTXVR?=
 =?iso-2022-jp?B?T05PcFlOQ1JXNzY2K1RvT0d3eTdHRWRWSlQ5Mkw5aFFLam5NbG8rMmRN?=
 =?iso-2022-jp?B?Tkp4N3dkQVdwOWp2Mmo0NHV4TGV5aHlwRk9scWo5cmMrb2ZGMkJTaHUv?=
 =?iso-2022-jp?B?Y3VGQUdSUVg3cWUraXViQkc1YmFjZmpURDdNRmNpMGp4cStFWHF2SWtj?=
 =?iso-2022-jp?B?bTJLQWF0T1EwbmJURVFPQkFIdFc2cEs2RGlzamVMZk52M0RKQXcxV1JD?=
 =?iso-2022-jp?B?UzUzRTlhR2syaG5tSWp3NE0xNXhwOVprRWNKeGwvaVpMejhLTDNtbWps?=
 =?iso-2022-jp?B?WHIxK3JsYkNhV0Y2UC9hVUR4T2RrMXE1NGtiQUh0WDhhdWNXR1JacDVJ?=
 =?iso-2022-jp?B?cXJ0SVFqUDdyTEppQzBFQkQ4bzlweWllVGw1eG5DdVV2Y3lBZGNKTlky?=
 =?iso-2022-jp?B?Z3ZHOTNRWHdnSWRSZkplazRHUXo5Sk9aREVRQmxWeTN0RFlzWW0wWFND?=
 =?iso-2022-jp?B?K2dnODhTNC9EUnJCdldKTWNsclJIWm05cU9RbmthRnRObUxNYm40aFpM?=
 =?iso-2022-jp?B?aDU1aFpaOUZzdDgwYWRRcGRlWndHOUhUbWd0cEsrRXpmNVBTaFB1TkxY?=
 =?iso-2022-jp?B?TjFZTCtVd0dWOVk1bnhsdE0rU2loc3d5SmFVNTQvd1JQN2VsQi9sT0pY?=
 =?iso-2022-jp?B?MVZ0V1o4RVJBbGVOaWU4Z284aUNGWTBhS2lQTDBEVzd6ZE9EcHczd2FV?=
 =?iso-2022-jp?B?YzBUVXhFUWtBYUd6Nnl1OHlGYUZPS09maS9hRUVTVjJFM0VoSU5QVHdL?=
 =?iso-2022-jp?B?YWl5WkpkWG1PdmVVQkd6M3laZXVhb0JmYmJyK1c3UCtRbnBWRUx1OW1X?=
 =?iso-2022-jp?B?Tmd3NVhzQ0xsUC8rMEZLTEtBaXVHTnQzVjNxR1N5RXJVVXFDQ1lVQXhQ?=
 =?iso-2022-jp?B?ZUhrK2NNRllUVjV0YkhCWlh2TVFjd09GM1A0YTI3Z3RuTlZjZW9lcU5N?=
 =?iso-2022-jp?B?a1JTRjFBNGRqZUQ3TVhHdW41YlQvbmhEbDFlR1MwVHRiekJMaE9DbWdy?=
 =?iso-2022-jp?B?Sm5mR1lpVzJWc2FUb2puL0pBZEJSVFlYVlhSWmtQZFl4RXpsNS9nY0Iv?=
 =?iso-2022-jp?B?aURpTkxRRTB3aE01KzI5ejJRdzRTZGNiQVpxd21XQUIrczVUemlIZ0NF?=
 =?iso-2022-jp?B?Y2RzSDAraDRYYzlvTVdNem5YQ2FyTUpIb1hhM0RoV2ttUTBINnRDS05P?=
 =?iso-2022-jp?B?cVAzNWFDQWJQMVNrc2xIbDVMeWJ2YVFJRXlKZUI4Z3FPSzN2YmpDYjhN?=
 =?iso-2022-jp?B?OUFzNS9RdEkrQnFra3I0Q3dvVm9pekxHOXlkaFMrYnVCQVpzb1lMV3hY?=
 =?iso-2022-jp?B?cml0ZWVFN0RFczFZMkhMcC9kOVlHYXFwZlZpWkFXWXFwcXdhbFc0bzcy?=
 =?iso-2022-jp?B?ZjAvcldsdlJIM291SE43RWtVT2xWZS9NemtmR1pIdFIwWEZkRnRQcytw?=
 =?iso-2022-jp?B?Y1VuZFdPS0VzTGUxNCtNV1hNRDhwb1lsQ0VkUXh6U0FENGpmeU1meWo2?=
 =?iso-2022-jp?B?dXNMNjNNMjRDNXZYZWtETlNYdGdUbTVUaGs4OUJsL092bkFSOStnVDVt?=
 =?iso-2022-jp?B?OFZJVmFYOEVPVjJqaWRycFI2bVdzZlFDcmpmMWNSQ1R5VHV3VWl3Tlk1?=
 =?iso-2022-jp?B?YUd4NER1ZE01NmdEUktjN3dIWnE1dTFrNG1EQTcxMFR0a08vbldhRkln?=
 =?iso-2022-jp?B?OEFqc09ZY1hmbUdrU2lTWXRsWlViVUVVNDJ5eDdoeFNOUHpUeGlUUlln?=
 =?iso-2022-jp?B?UkJYY0lOTzhaSXZPNlpJU3kvcHBQb0p2WThHNWNVbkJhKzViWmlvRktz?=
 =?iso-2022-jp?B?YXRQZldkSjY3bmhxOHhWVWNZbU5BdzU2MjZLeXVvUU04cVpkZFdtTjlp?=
 =?iso-2022-jp?B?NjhmM00yQlRTTzFCVWQyRkxPdWlwUUtPcGFsMmpLNmJyMERHTGtMUmxN?=
 =?iso-2022-jp?B?MVZZV3QyeGljRHdLdjhzMGtHajBjS1pESWFQQkF3a1NlcEhxZlhKMkE0?=
 =?iso-2022-jp?B?QitSV1hsYk5nQm9yK2xwSjN4MVZyYjJ1MGpQdndIQW85dU01ZVNnTlpX?=
 =?iso-2022-jp?B?dk5LR3YvT2tsaHFKUG5UNCtZUEtjY2o5amJOcVU0UUcxOEpBdk1lZFpG?=
 =?iso-2022-jp?B?Z0tRY1FKN1dTd0ZTOE0zVndlQTZHYjErS1FpQ2FsTnNnSDRzdStzOTJF?=
 =?iso-2022-jp?B?bnY3dWFUaHBuRk5BYklseEt0eHBvOWtFelpHSkg4Mk9IcytkQWE5Tkdw?=
 =?iso-2022-jp?B?QmMzekFQRDlQQXpKVzZsYzBuZlZuUzhmOEE9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_TYCPR01MB11385C6C2D03D46AF20294DF3E13B2TYCPR01MB11385jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac43657f-cbb5-4570-5fab-08dd1d9fb97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 07:03:20.5372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxCKMmo8uH5ZBPdgqBQStCgYPWoi0k2CwFd0X0SGkotb4xXsTlei48xqYCgqSCk4OP160SsFVi+gy23EoE9OZ/V1oBsC1jTiMT9Rib0JA42RC5H3psPRUtpuPc+Q897M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11018
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 07:03:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17422

--_002_TYCPR01MB11385C6C2D03D46AF20294DF3E13B2TYCPR01MB11385jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Pavel, kernel maintainers,

> I'm checking several codes in v6.1-rt where the early might_sleep() detec=
ts BUGs
> while kernel booting, but no fix from the RT perspective has been found s=
o far.

Please check the attachment for more details about this investigation.
Here is a brief summary:

* No fix about the bug callers is found in v6.1-rt : (1)(2)(3)(4)(6)(8)
* __GFP_DIRECT_RECLAIM is set in v6.1-rt but not a RT fix : (5)
* The bug callers are removed (cannot compare) : (7)

I concluded that there is no RT "fix" for the might_sleep BUGs in newer RT =
kernels.
The memory allocator seems to be responsible to enable IRQ properly based o=
n
the "system_state" (regardless of GFP flags of its callers).

Thus, I'd like to check if CIP can add "SYSTEM_SCHEDULING" to 4.4.y-cip-rt =
or not first,
then have to find another way out if that's not applicable.

Best regards,
Kazu

--_002_TYCPR01MB11385C6C2D03D46AF20294DF3E13B2TYCPR01MB11385jp_
Content-Type: text/plain; name="might-sleep-bugs_gfp-flags-summary.txt"
Content-Description: might-sleep-bugs_gfp-flags-summary.txt
Content-Disposition: attachment;
	filename="might-sleep-bugs_gfp-flags-summary.txt"; size=6695;
	creation-date="Mon, 16 Dec 2024 06:55:11 GMT";
	modification-date="Mon, 16 Dec 2024 07:03:20 GMT"
Content-Transfer-Encoding: base64

W0Fib3V0XQoKVGhpcyBmaWxlIHN1bW1hcml6ZXMgZGV0YWlscyBvZiB2NC40LXJ0IGNvZGVzIHRo
YXQgbWFrZSBtaWdodF9zbGVlcCgpIEJVR3MKY2F0ZWdvcml6ZWQgaW4gYW5vdGhlciBhdHRhY2ht
ZW50ICJjYXRlZ29yaXplZC1taWdodC1zbGVlcC1idWdzLnR4dCIuCgpbQ29uZGl0aW9uIHRoYXQg
YWxsb2NhdGVfc2xhYigpIGRvZXMgTk9UIGVuYWJsZSBJUlFdCgpJbiB2NC40LXJ0LCBhbGxvY2F0
ZV9zbGFiKCkgZG9lcyBOT1QgZW5hYmxlIElSUSBpZi4uLgoKKiBnZnBmbGFnc19hbGxvd19ibG9j
a2luZyhnZnBfZmxhZ3MpIGlzIGZhbHNlCiogc3lzdGVtX3N0YXRlICE9IFNZU1RFTV9SVU5OSU5H
CgpnZnBmbGFnc19hbGxvd19ibG9ja2luZyhnZnBfZmxhZ3MpIHJldHVybnMgZmFsc2UgaWYKX19H
RlBfRElSRUNUX1JFQ0xBSU0gaXMgbm90IHNldCBpbiBnZnBfZmxhZ3MuCgpbU3VtbWFyeV0KCiog
Tm8gZml4IGFib3V0IHRoZSBidWcgY2FsbGVycyBpcyBmb3VuZCBpbiB2Ni4xLXJ0IDogKDEpKDIp
KDMpKDQpKDYpKDgpCiogX19HRlBfRElSRUNUX1JFQ0xBSU0gaXMgc2V0IGluIHY2LjEtcnQgYnV0
IG5vdCBhIFJUIGZpeCA6ICg1KQoqIFRoZSBidWcgY2FsbGVycyBhcmUgcmVtb3ZlZCAoY2Fubm90
IGNvbXBhcmUpIDogKDcpCgpbKDEpIGtkZXZ0bWZzKCldCgphdmNfYWxsb2Nfbm9kZSgpIEAgc2Vj
dXJpdHkvc2VsaW51eC9hdmMuYzoKICBrbWVtX2NhY2hlX3phbGxvYyhhdmNfbm9kZV9jYWNoZXAs
IEdGUF9OT1dBSVQgfCBfX0dGUF9OT1dBUk4pIEAgaW5jbHVkZS9saW51eC9zbGFiLmgKICAgIGtt
ZW1fY2FjaGVfYWxsb2MoaywgZmxhZ3MgfCBfX0dGUF9aRVJPKQooVGhlIEdGUCBmbGFncyBhcmUg
ZGVmaW5lZCBpbiBpbmNsdWRlL2xpbnV4L2dmcC5oKQoKKiBHRlBfTk9XQUlUIDogX19HRlBfRElS
RUNUX1JFQ0xBSU0gaXMgbm90IHNldAoqIF9fR0ZQX05PV0FSTiBhbmQgX19HRlBfWkVSTyBhcmUg
dW5yZWxhdGVkIHRvIF9fR0ZQX0RJUkVDVF9SRUNMQUlNCiogZ2ZwZmxhZ3NfYWxsb3dfYmxvY2tp
bmcoKSByZXR1cm5zIGZhbHNlCiogSW4gdjYuMS1ydCwgbm8gY2hhbmdlIChubyBmaXgpIGluIHRo
ZSBHRlAgZmxhZyBzZXR0aW5ncwoKWygyKSBrZGV2dG1mcygpXQoKc2VsaW51eF9uZXRsYmxfc29j
a19nZW5hdHRyKCkgQCBzZWN1cml0eS9zZWxpbnV4L25ldGxhYmVsLmMKICBuZXRsYmxfc2VjYXR0
cl9hbGxvYyhHRlBfQVRPTUlDKSBAIGluY2x1ZGUvbmV0L25ldGxhYmVsLmgKICAgIGt6YWxsb2Mo
Li4uLCBmbGFncykKICAgICAga21hbGxvYyguLi4sIGZsYWdzIHwgX19HRlBfWkVSTykKICAgICAg
ICBrbWVtX2NhY2hlX2FsbG9jX3RyYWNlKGZsYWdzKQoKKiBHRlBfQVRPTUlDIDogX19HRlBfRElS
RUNUX1JFQ0xBSU0gaXMgbm90IHNldAoqIGdmcGZsYWdzX2FsbG93X2Jsb2NraW5nKCkgcmV0dXJu
cyBmYWxzZQoqIEluIHY2LjEtcnQsIG5vIGNoYW5nZSAobm8gZml4KSBpbiB0aGUgR0ZQIGZsYWcg
c2V0dGluZ3MKClsoMykgdGNwX3Y0X2luaXQoKV0KClRoZSBjYWxsZXIgZnVuY3Rpb25zIGFyZSB0
aGUgc2FtZSBhcyAoMikKClsoNCkgc2RdCgptZW1wb29sX2FsbG9jKHBvb2wsIGdmcF9tYXNrKSBA
IG1tL21lbXBvb2wuYwogIHBvb2wtPmFsbG9jKGdmcF90ZW1wLCAuLi4pICMgZ2ZwX3RlbXA6IF9f
R0ZQX0RJUkVDVF9SRUNMQUlNIGFuZCBfX0dGUF9JTyBhcmUgY2xlYXJlZCBieSBnZnBfbWFzayBo
ZXJlCiAgICBhbGxvY19yZXF1ZXN0X3N0cnVjdChnZnBfbWFzaywgLi4uKSBAIGJsb2NrL2Jsay1j
b3JlLmMKICAgICAga21lbV9jYWNoZV9hbGxvY19ub2RlKC4uLiwgZ2ZwX21hc2ssIC4uLikKCiog
X19HRlBfRElSRUNUX1JFQ0xBSU0gaXMgYWx3YXlzIGNsZWFyZWQgYnkgbWVtcG9vbF9hbGxvYygp
CiogZ2ZwZmxhZ3NfYWxsb3dfYmxvY2tpbmcoKSByZXR1cm5zIGZhbHNlCiogSW4gdjYuMS1ydCwg
bm8gY2hhbmdlIChubyBmaXgpIGluIHRoZSBHRlAgZmxhZyBzZXR0aW5ncwogICogX19HRlBfRElS
RUNUX1JFQ0xBSU0gaXMgYWx3YXlzIGNsZWFyZWQKClsoNSkgaW5ldDZfaW5pdCgpXQoKaW5ldDZf
aW5pdCgpIEAgbmV0L2lwdjYvYWZfaW5ldDYuYwogIGFkZHJjb25mX2luaXQoKSBAIG5ldC9pcHY2
L2FkZHJjb25mLmMKICAgIC4uLgogICAgICBpcHY2X2FkZF9kZXYoKQogICAgICAgIGlwdjZfZGV2
X21jX2luYygpIEAgbmV0L2lwdjYvbWNhc3QuYwogICAgICAgICAgbWNhX2FsbG9jKCkKICAgICAg
ICAgICAga3phbGxvYyguLi4sIEdGUF9BVE9NSUMpIEAgaW5jbHVkZS9saW51eC9zbGFiLmgKICAg
ICAgICAgICAgICBrbWFsbG9jKC4uLiwgZmxhZ3MgfCBfX0dGUF9aRVJPKQogICAgICAgICAgICAg
ICAga21lbV9jYWNoZV9hbGxvY190cmFjZShmbGFncykKCkZ1bmN0aW9uIGNhbGxzIGFmdGVyIGt6
YWxsb2MoLi4uLCBHRlBfQVRPTUlDKSBhcmUgdGhlIHNhbWUgYXMgKDIpKDMpCgoqIGdmcGZsYWdz
X2FsbG93X2Jsb2NraW5nKCkgcmV0dXJucyBmYWxzZQoqIEluIHY2LjEtcnQsIEdGUF9BVE9NSUMg
aXMgY2hhbmdlZCB0byBHRlBfS0VSTkVMLCB3aGljaCByZXN1bHRzIGluCiAgZ2ZwZmxhZ3NfYWxs
b3dfYmxvY2tpbmcoKSByZXR1cm5zIHRydWUsIGJ1dCBpdCdzIG5vdCBtYWRlIGFzCiAgYSBmaXgg
Zm9yIFJUIGJ1dCBhIGZ1bmN0aW9uYWwgY2hhbmdlIGluIHRoZSBtYWlubGluZSBrZXJuZWw6CiAg
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC9mMTg1ZGUyOGQ5YWU2Yzk3
ODEzNTk5Mzc2OTM1MmU1MjNlZThkZjA2CgpbKDYpIHNpdF9pbml0KCldCgpGdW5jdGlvbiBjYWxs
cyBhZnRlciBpcHY2X2Rldl9tY19pbmMoKSBhcmUgdGhlIHNhbWUgYXMgKDUpCgpbKDcpIG1vdW50
X3Jvb3QoKV0KCmdlbmVyaWNfbWFrZV9yZXF1ZXN0X2NoZWNrcygpIEAgYmxvY2svYmxrLWNvcmUu
YwogIGNyZWF0ZV9pb19jb250ZXh0KEdGUF9BVE9NSUMsIC4uLikgQCBibG9jay9ibGsuaAogICAg
Y3JlYXRlX3Rhc2tfaW9fY29udGV4dCguLi4sIGdmcF9tYXNrLCAuLi4pIEAgYmxvY2svYmxrLWlv
Yy5jCiAgICAgIGttZW1fY2FjaGVfYWxsb2Nfbm9kZSguLi4sIGdmcF9mbGFncyB8IF9fR0ZQX1pF
Uk8sIC4uLikKCiogR0ZQX0FUT01JQyA6IF9fR0ZQX0RJUkVDVF9SRUNMQUlNIGlzIG5vdCBzZXQK
KiBnZnBmbGFnc19hbGxvd19ibG9ja2luZygpIHJldHVybnMgZmFsc2UKKiBJbiB2Ni4xLXJ0LCBh
bGwgdGhlIGJsb2NrIGZ1bmN0aW9ucyBhcmUgcmVtb3ZlZCBzbwogIEkgY291bGQgbm90IGNvbXBh
cmUgdjQuNC1ydCBhbmQgdjYuMS1ydAoKWyg4KSB0Y3BfaW5pdCgpIChBZGRpdGlvbmFsIEJVRyBw
YXR0ZXJuKV0KClRoaXMgQlVHIG9jY3VycyBvbmx5IHdoZW4gdGhlIG1pZ3JhdGVfZW5hYmxlKCkg
cmVwZWF0ZWQgV0FSTklORyBoYXBwZW5zLgoKWyAgICAwLjM4ODgyOF0gQlVHOiBzbGVlcGluZyBm
dW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQgL2hvbWUvamVzc2llL3dvcmsv
bGludXgva2VybmVsL2xvY2tpbmcvcnRtdXRleC5jOjk5NApbICAgIDAuMzg4ODI5XSBpbl9hdG9t
aWMoKTogMCwgaXJxc19kaXNhYmxlZCgpOiAxLCBwaWQ6IDEsIG5hbWU6IHN3YXBwZXIvMApbICAg
IDAuMzg4ODMxXSBDUFU6IDIgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA0LjQu
MzAyLXJ0MjMyICMxClsgICAgMC4zODg4MzJdIEhhcmR3YXJlIG5hbWU6IGlubm90ZWsgR21iSCBW
aXJ0dWFsQm94L1ZpcnR1YWxCb3gsIEJJT1MgVmlydHVhbEJveCAxMi8wMS8yMDA2ClsgICAgMC4z
ODg4MzVdICAwMDAwMDAwMDAwMDAwMDAwIGZmZmY4ODAwN2NhYzc5MDAgZmZmZmZmZmY4MTkwNzU3
OSAwMDAwMDAwMDAwMDAwMDAwClsgICAgMC4zODg4MzddICBmZmZmODgwMDdjYWM3YWQwIGZmZmY4
ODAwN2NhYzc5MTggZmZmZmZmZmY4MTA3ZWU3ZCBmZmZmODgwMDdkNTE3N2MwClsgICAgMC4zODg4
NDBdICBmZmZmODgwMDdjYWM3OTMwIGZmZmZmZmZmODE5MTMwYmIgMDAwMDAwMDAwMDAwMDAwMCBm
ZmZmODgwMDdjYWM3OWYwClsgICAgMC4zODg4NDBdIENhbGwgVHJhY2U6ClsgICAgMC4zODg4NDRd
ICBbPGZmZmZmZmZmODE5MDc1Nzk+XSBkdW1wX3N0YWNrKzB4NTkvMHg2ZgpbICAgIDAuMzg4ODQ3
XSAgWzxmZmZmZmZmZjgxMDdlZTdkPl0gX19fbWlnaHRfc2xlZXArMHhlZC8weDE0MApbICAgIDAu
Mzg4ODQ4XSAgWzxmZmZmZmZmZjgxOTEzMGJiPl0gcnRfc3Bpbl9sb2NrKzB4MWIvMHg1MApbICAg
IDAuMzg4ODUxXSAgWzxmZmZmZmZmZjgxMTNiZDgxPl0gZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsw
eDY3MS8weGI4MApbICAgIDAuMzg4ODUzXSAgWzxmZmZmZmZmZjgxMTNiYmE0Pl0gPyBnZXRfcGFn
ZV9mcm9tX2ZyZWVsaXN0KzB4NDk0LzB4YjgwClsgICAgMC4zODg4NTRdICBbPGZmZmZmZmZmODE5
MGY0ZTY+XSA/IF9fc2NoZWR1bGUrMHgyOTYvMHg1ZDAKWyAgICAwLjM4ODg1Nl0gIFs8ZmZmZmZm
ZmY4MTEzYzUyYT5dIF9fYWxsb2NfcGFnZXNfbm9kZW1hc2srMHgxOGEvMHhiYjAKWyAgICAwLjM4
ODg1OF0gIFs8ZmZmZmZmZmY4MTE3Y2JmMD5dID8gYWxsb2NfcGFnZV9pbnRlcmxlYXZlKzB4ODAv
MHg5MApbICAgIDAuMzg4ODYwXSAgWzxmZmZmZmZmZjgxMDVhYTUxPl0gPyB1bnBpbl9jdXJyZW50
X2NwdSsweDExLzB4NjAKWyAgICAwLjM4ODg2Ml0gIFs8ZmZmZmZmZmY4MTA4MTgwYz5dID8gbWln
cmF0ZV9lbmFibGUrMHgyNmMvMHgzYzAKWyAgICAwLjM4ODg2NF0gIFs8ZmZmZmZmZmY4MTE3Y2Jh
OT5dIGFsbG9jX3BhZ2VfaW50ZXJsZWF2ZSsweDM5LzB4OTAKWyAgICAwLjM4ODg2Nl0gIFs8ZmZm
ZmZmZmY4MTE3ZDQ0Yz5dIGFsbG9jX3BhZ2VzX2N1cnJlbnQrMHhjYy8weDExMApbICAgIDAuMzg4
ODY5XSAgWzxmZmZmZmZmZjgxMzRlYzJmPl0gPyBkZWxheV90c2MrMHhjZi8weDEyMApbICAgIDAu
Mzg4ODcwXSAgWzxmZmZmZmZmZjgxMTgxYTdmPl0gbmV3X3NsYWIrMHgyZWYvMHgzODAKWyAgICAw
LjM4ODg3Ml0gIFs8ZmZmZmZmZmY4MTE4NGRkYj5dIF9fX3NsYWJfYWxsb2MrMHgzZmIvMHg1MzAK
WyAgICAwLjM4ODg3OF0gIFs8ZmZmZmZmZmY4MTE2ZjE4OT5dID8gX192bWFsbG9jX25vZGVfcmFu
Z2UrMHhjOS8weDI4MApbICAgIDAuMzg4ODc4XSAgWzxmZmZmZmZmZjgxMDVhYTUxPl0gPyB1bnBp
bl9jdXJyZW50X2NwdSsweDExLzB4NjAKWyAgICAwLjM4ODg4MF0gIFs8ZmZmZmZmZmY4MTE4NGY2
YT5dIF9fc2xhYl9hbGxvYy5pc3JhLjczKzB4NWEvMHg4MApbICAgIDAuMzg4ODgyXSAgWzxmZmZm
ZmZmZjgxMTZmMTg5Pl0gPyBfX3ZtYWxsb2Nfbm9kZV9yYW5nZSsweGM5LzB4MjgwClsgICAgMC4z
ODg4ODRdICBbPGZmZmZmZmZmODExODUwM2E+XSBfX2ttYWxsb2Nfbm9kZSsweGFhLzB4MmYwClsg
ICAgMC4zODg4ODZdICBbPGZmZmZmZmZmODExNmQ4NGE+XSA/IF9fZ2V0X3ZtX2FyZWFfbm9kZSsw
eGZhLzB4MTYwClsgICAgMC4zODg4ODhdICBbPGZmZmZmZmZmODExNmYxODk+XSBfX3ZtYWxsb2Nf
bm9kZV9yYW5nZSsweGM5LzB4MjgwClsgICAgMC4zODg4OTBdICBbPGZmZmZmZmZmODFmODgxMjY+
XSA/IGFsbG9jX2xhcmdlX3N5c3RlbV9oYXNoKzB4MTc2LzB4MjM2ClsgICAgMC4zODg4OTJdICBb
PGZmZmZmZmZmODEwYWE5NGE+XSA/IHZwcmludGtfZGVmYXVsdCsweDFhLzB4MjAKWyAgICAwLjM4
ODg5NF0gIFs8ZmZmZmZmZmY4MTE2ZjM4NT5dIF9fdm1hbGxvYysweDQ1LzB4NTAKWyAgICAwLjM4
ODg5NV0gIFs8ZmZmZmZmZmY4MWY4ODEyNj5dID8gYWxsb2NfbGFyZ2Vfc3lzdGVtX2hhc2grMHgx
NzYvMHgyMzYKWyAgICAwLjM4ODg5N10gIFs8ZmZmZmZmZmY4MWY4ODEyNj5dIGFsbG9jX2xhcmdl
X3N5c3RlbV9oYXNoKzB4MTc2LzB4MjM2ClsgICAgMC4zODg5MDBdICBbPGZmZmZmZmZmODE3N2Uy
YmM+XSA/IGluZXRfZWhhc2hfbG9ja3NfYWxsb2MrMHg1Yy8weDEwMApbICAgIDAuMzg4OTAyXSAg
WzxmZmZmZmZmZjgxZmI5YWViPl0gPyBpcHY0X29mZmxvYWRfaW5pdCsweDYxLzB4NjEKWyAgICAw
LjM4ODkwM10gIFs8ZmZmZmZmZmY4MWZiOTM1ZD5dIHRjcF9pbml0KzB4MTE0LzB4MmM1ClsgICAg
MC4zODg5MDVdICBbPGZmZmZmZmZmODFmYjljODY+XSBpbmV0X2luaXQrMHgxOWIvMHgyOGEKWyAg
ICAwLjM4ODkwN10gIFs8ZmZmZmZmZmY4MTAwMDNiNT5dIGRvX29uZV9pbml0Y2FsbCsweDg1LzB4
MWIwClsgICAgMC4zODg5MDldICBbPGZmZmZmZmZmODFmNjUwMjU+XSBrZXJuZWxfaW5pdF9mcmVl
YWJsZSsweDFiZS8weDI0YgpbICAgIDAuMzg4OTExXSAgWzxmZmZmZmZmZjgxOTBkZDAwPl0gPyBy
ZXN0X2luaXQrMHhlMC8weGUwClsgICAgMC4zODg5MTJdICBbPGZmZmZmZmZmODE5MGRkMDk+XSBr
ZXJuZWxfaW5pdCsweDkvMHhlMApbICAgIDAuMzg4OTE0XSAgWzxmZmZmZmZmZjgxOTEzYTU1Pl0g
cmV0X2Zyb21fZm9yaysweDU1LzB4ODAKWyAgICAwLjM4ODkxNl0gIFs8ZmZmZmZmZmY4MTkwZGQw
MD5dID8gcmVzdF9pbml0KzB4ZTAvMHhlMAoKCmFsbG9jX2xhcmdlX3N5c3RlbV9oYXNoKCkgQCBt
bS9wYWdlX2FsbG9jLmMKICBfX3ZtYWxsb2MoLi4uLCBHRlBfQVRPTUlDLCAuLi4pCgoqIEdGUF9B
VE9NSUMgOiBfX0dGUF9ESVJFQ1RfUkVDTEFJTSBpcyBub3Qgc2V0CiogZ2ZwZmxhZ3NfYWxsb3df
YmxvY2tpbmcoKSByZXR1cm5zIGZhbHNlCiogSW4gdjYuMS1ydCwgbm8gY2hhbmdlIChubyBmaXgp
IGluIHRoZSBHRlAgZmxhZyBzZXR0aW5ncwo=

--_002_TYCPR01MB11385C6C2D03D46AF20294DF3E13B2TYCPR01MB11385jp_--



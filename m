Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F016D172B3
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 02:00:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43760.1769997647735893256
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Feb 2026 18:00:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=hDsEkpqJ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769997645;x=1771207245;bh=e9NsDKqo1/4ORNKYqbSb0T3Wggti4U4OMFPjG
	CuNX8Q=;b=hDsEkpqJ4+CdbBlhwUJCUs/mA+qlZ7n30QrpctaOnrlL7qgAxYjUVTOhfWXIN2QZjJM
	fsxbL4KqUUiuICv8vYgVFZNfSgzHdS7UaBOWuYNZMNRgfeNnpGKnN034+x/R9X2vMnsj/zOnvjA2V
	yp81qq8tlvzKVzcOj/wV7LIQtPZc59s6SSSaf1wv2DLMGKAo7LZZ5uXwcbGJn4Bmu64XGpNeYbCPQ
	VEOL20fDYjRA120UEg7EQQhiLB0UizJj5RXy1ergFutB8ck0Fl24E4JHwau4Zn/2arI/HJaPJy2Ed
	4wnMClymuoj9WXq33zdBEzMdv9f0PIQi8gBk7II4Lhmg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 61220iL53554118; Mon, 2 Feb 2026 11:00:45 +0900
X-Iguazu-Qid: 2yAbYAX4jrxYwHhYfN
X-Iguazu-QSIG: v=2; s=0; t=1769997644; q=2yAbYAX4jrxYwHhYfN; m=TzuX92OpWO7h/7ZPAeItBCgqdepwroxHpTQY199QYnQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f48wD2xBRzyPZ; Mon,  2 Feb 2026 11:00:44 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZhJtzy17AIwjmjfMhn92MWlbk0rHKaHyWl6+JDcOV9B3pzYumyGot0bPML8zocaBSM3S8MObOMH/3JC35JENWeD/9uIQ6MK+q4Qwa9Es6+mkcE89CPlFi1ruvuAkVR9fjaSYohxiMTFRZXDhA16pcrdPr/0PDMKBtiaLG1pJzMTEyDvixnHltTQDj7oUQED72A8scWAYd89ogv9I9MNbGBusMhQTxxuR41LvvXBzVniAqBz85mFqLT+dMrwUzGMJfysPC4iKyBoRcNS6jdd+Rrh+XM00t7uRcTGhLObIe6US8ofR2CpsJQ3q6GT3Z3VkoPtyoUMBQrKngjN5IOtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxeIiixGEu7u2UI8FsuWt2vU08Drd4515TKWFjiGO2M=;
 b=s5LQs6NObffPvJlpfMDAVPp8N3taI4QGZZJL+6rN2VWxWC2kiEJy6BES2xzRJt0+OvOzvj/DneBRiZIEReEjakxxLg+e9TUn/k7mBGcSWkO+SxVAEFG/biay9qChKlAM26reCF/mNpA6Ob4ufxMBUfIchQnulrhEK9LlCIsAXWFhl04H8mino+p/TO7Bks05xomOFcLQLhQG7VpU4pX7AUzbjf1WlB7Tx0KC/40lh3sMzwzRmF1LdIFJ/nahG5SjxZFVXKMS3covzM6Yr/qR3pgKs22XorjoSSUPEaAqTxG7Bp6er7pZF4uS1deAKB65FM878huI3NW0NBdgLL1gRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
Thread-Topic: [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
Thread-Index: AQHckFmWDEZFO47JiE2v8ixOLy4UobVozFJAgAXiMQA=
Date: Mon, 2 Feb 2026 02:00:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DE9A3E9F0D4E49132C7FCD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148183B37BD1A587297164320CD9EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148183B37BD1A587297164320CD9EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB16213:EE_
x-ms-office365-filtering-correlation-id: a453948a-00b2-47ef-e703-08de61fede05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?d2ZoaS9FYStnaFd2NGY1L3pZcmhpOE1uMGhFWjB3d1dtMm1Rb1pCeGhD?=
 =?iso-2022-jp?B?eFFjK2xJaHhkalYzU0pUdXc0VjJheFZTYVZ3RGhic1JxY2EzZlZoM3Zs?=
 =?iso-2022-jp?B?alF2TS95VUlSUDhRUW1MdUdJeU9EV1BJVThXVUFYcnJ4djFNZ3I0Nytk?=
 =?iso-2022-jp?B?dnZTT3luTXpFM2N3ampyZm5iRS9DbHRNMEMzemV0dlRCblhvbmdhWklX?=
 =?iso-2022-jp?B?elJaNWZySGdpOHRiTVN2UEdaS2VEZ0FjWlQxRkpxWXdDc3NwajhkdkVW?=
 =?iso-2022-jp?B?azc5alFDNjM3SGMvOHUrdkd5UHNscHJiNUpYQzZFcUIrZHVKd2NXN1Zj?=
 =?iso-2022-jp?B?NysrdHd0T2FubGg1WHVacEpycWRuZCtiZmIyN2VISWF0d25FZDRCVzBw?=
 =?iso-2022-jp?B?UnZDem83b29hdTA2VmJianV1bC9YNlhqRzZlNHFJSDhNNm1HWTdyVVVn?=
 =?iso-2022-jp?B?aUg0eU9ZRTNVWGRrRmJURFpNZTN1eWZoTXdVY0RYbE05MFVXS0NCcnlj?=
 =?iso-2022-jp?B?WUtKTVd2QmxsVXovYlB1eDY0UzhRV0pZT0lSRVBqNkQyTTFCR3VGbzBC?=
 =?iso-2022-jp?B?VzBUaWcreXpxMmZKVHJYL3I0ZDdBYjhOYnFaWnpWbHhoaHdBMTNUUmVL?=
 =?iso-2022-jp?B?ZFR3azMyYzQxV1NVbUExSG9PelRPSVZCUzdCQUg1dEorSkpsTlFuR3Rn?=
 =?iso-2022-jp?B?ZTI0Rlk3Tm5pbDEycVAzUDh5aDhEallOWlhaK25Td1BkbzNHRlZUMGc5?=
 =?iso-2022-jp?B?Q2tISFd2TTJQKzU2amg4cGRrV1BYTk5JcXBaVU4wcXlDcEFUMW5aYW1B?=
 =?iso-2022-jp?B?Vk44dWFKWHVaTjNnY3UrcE41YWFTRVRlVmg5QTBrRzh6TDh1YktIWXNu?=
 =?iso-2022-jp?B?WGZpaCtTaDdLRXo1ZkN5YzVKT0pkK3pOSEU5L3RQSE1aTG9XeW9aUnda?=
 =?iso-2022-jp?B?ZElUVUZGc0E0NkVVcUM3KzJrUmFlUW9tMHNhUDJJZ1dNRks1VlkxblE5?=
 =?iso-2022-jp?B?bk00K0dwVzJJZ0lmMmdSMnNPVUJrckpWNytGM0FkNndjNEQ5aVhEeGo1?=
 =?iso-2022-jp?B?VjhFN0Y0ZzduYzM1N1JYR1F3d0h0Y3hLa0NTRXhXTFRleWpEVk5JZWNs?=
 =?iso-2022-jp?B?ejd5S0dNVnZkeFhKWVlpTU5BTkhLaGVtWitBdjZQNytsUitZcVZSTHY2?=
 =?iso-2022-jp?B?WG5HSlZsNUVDM2tNdVk3SWR1N0VINnc5c01DQVBFcmFBVkMzcWhESEdo?=
 =?iso-2022-jp?B?VDAvQjY1Rm5SYm5HTlRXV3dxdUVBdDEyRlZoK2puUmp2ekRJS3FmTlM2?=
 =?iso-2022-jp?B?SVZqMytjN3VZMDRLa1c1bzVta0F4dHVKV3RPMDY4Nit1QkluQURuYVFF?=
 =?iso-2022-jp?B?YXc0WW44Sk1oZUsrQmRDdGt2aGpBeWwzcCs4cWFaUnJjVUFqUnZPUmMv?=
 =?iso-2022-jp?B?TmF4N0VDTUVudU5QeGc1OVlZc3MrWG1KTjhkR2ZaUlZTUHYzWmt6KzB4?=
 =?iso-2022-jp?B?b0cxaWt5NnhwR2E5OW9haW0zTCs3bHpybmo3cm5LRCtEQWlsQ1VsYTZG?=
 =?iso-2022-jp?B?eVM2bWtqWXJyUFVMT3YwZFBaNHZjTGtFdHVrb2E4cEcrMVB0VkNwaXhS?=
 =?iso-2022-jp?B?ckxoc1oxUE9zRzdNUkFubTZPTlYyQmdCRE13bHNEL2puYXA2emROalZJ?=
 =?iso-2022-jp?B?ZExlWnNjS3BiekZ2QXpmQ3RidUxSZ1JBK0hSSVhHWlVPZEs3b25MTy9l?=
 =?iso-2022-jp?B?dWpRVHZLZ3J1M01vRGM4dlVoeitIM0Y1MjlLNVEwa1VyVzE0NzVwNjBz?=
 =?iso-2022-jp?B?c1NoQnJJNDJudjhuQk4vTFh6bXcyME55OGJJNitreG5mMTdPK2pWejVk?=
 =?iso-2022-jp?B?cCtyell6elN4SVF4SVVFYzArT1MvME9oSnRXcUUyZUdzcEV3NkRRenpJ?=
 =?iso-2022-jp?B?WkprR01qTWZLVzZZbUJISS90bWh1YVhESk9yTDRZRXlXZG4wZlpuUVJr?=
 =?iso-2022-jp?B?YzkyTlozNU0xQmVXeHJFZWJoVGhRSnRDSW9Eazk5UnYzU0VRb2hBWnhW?=
 =?iso-2022-jp?B?UVIxbG4xd3YxZHJJQkRVSnp4cXRqVERZdjlLWk5WWmx0dEhKUkpXSHhX?=
 =?iso-2022-jp?B?MTF0LzNkditlNjEyZHh2Q2t5M2R1QlJaL1VjTEQwVEJ3eFZrenYzT3lq?=
 =?iso-2022-jp?B?c1lRcHd6NVp6ZjRXMTFQbVlHVGZPOVRzTWtyMldZMUlpaEtiM2VkN1Ro?=
 =?iso-2022-jp?B?eTcwSFJiVlBHRHhkMXBRQmNiOTYzR0Q4cmhyOEpEMXVRazgxYlRUcXNs?=
 =?iso-2022-jp?B?bFVqRkVMaERWdUx2WFg4a0Y0ZlpYb29zMXJLLzBGT2VHa1JCbEJQM25j?=
 =?iso-2022-jp?B?UmVMcmc9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ckVUZXIyL1NzRWZoTllNUXZyUUMvTWpkNkQ0clNTU0s3MjJDL3QrZ3dv?=
 =?iso-2022-jp?B?M2NuenJVOUVIQ29sV2pwRE1JSEtyY2tSRC9mbHpqUkR0NllOUldCaHpt?=
 =?iso-2022-jp?B?ZHVOa2tFNkR1emhRZmRkVyswZlBvcVI0VkM4QUkyeXFiM0F6QjQ1bmtR?=
 =?iso-2022-jp?B?d1JRSVVtSnlwV2FFWmZEb3dBT3pUeGZQWmZNK1JZcmhMZXlSanFNM2du?=
 =?iso-2022-jp?B?eURuUzRiSFh4L1BiRlB3SEIrMnZjZEZDb2NaWUxidlJVMkFOL3cxcUJX?=
 =?iso-2022-jp?B?VTZrTWxQc3NXcnJCanExR0ZIMjNPS3VTMWExWlMrandtMy93QjAxNFpZ?=
 =?iso-2022-jp?B?WXAzNEdkQWo1dVZ4ZFBBL2NhODBQd05VRWZzR3pDUC9nV0FEZlFHRzRM?=
 =?iso-2022-jp?B?RW1HQUxOUEd1VmFJV05SV2xyQ3o4dTlmRldFK2JnR3ZIT3hUaEUyY0Ez?=
 =?iso-2022-jp?B?cmZLMkJrUll2Ky92RURsYzNGZkJxTXQyenVuZWt3NktMZEtZYXlENERl?=
 =?iso-2022-jp?B?VHQ5VWo4THU1Rjg0MlM4SDlSZHNMdzl1ei85Sjd5UkNOOFUrZmp6L2kv?=
 =?iso-2022-jp?B?OXBkY1pmTFpxRWc3b0grb2NGeS8wK3U2MEgyNXJKUzRENDJ5NENtM1RK?=
 =?iso-2022-jp?B?Z1hRNGFTOTBQS1hhY0ZzOHYrTFBjQUhVNjFSNjNNLzFvTUJKWlJYVGxt?=
 =?iso-2022-jp?B?NEQwTGV0NjhaNTJCNUpYbGh1N0tKZGFnaFJZcWVYa3gwUnNwNHBvSDZl?=
 =?iso-2022-jp?B?OTRKbVZtUkt0eFA0M2lhYXBjcHdZWVFxU1pJbm5mS0UzS2xHeEhoZThi?=
 =?iso-2022-jp?B?RU1NRlN0Snp3ckQydUlBN1RmdnhVMUY5WXNZSnJ6c1I0QjlXT2REd3I3?=
 =?iso-2022-jp?B?elVPWEMrOXFna1dCbjIyQnpod0xHSEZUODZTT2RmNHROcnk3WkVuWjFU?=
 =?iso-2022-jp?B?eUtIWXpNaytCZ1ZsRGVBNmhRekF0bEhkUWFEa3I2RXRQTnFhZmtVazNn?=
 =?iso-2022-jp?B?aEd6aXIzS1YvSFRSU1BHQVVtUmNlLzM0VTRpaGtHVWlzc1R0S0lUU1l5?=
 =?iso-2022-jp?B?dUxaeWxhSFRaWlZXMmI5cU5yRytuNnFNdFk5eDRqQ01aOThXd25zQm9K?=
 =?iso-2022-jp?B?NXp5TjdYN0xaY1ZKaHdnT1E2UFFBUjNMNlVaQmxyNWpTY0Y0MU9MT3Nm?=
 =?iso-2022-jp?B?RTZOVmR1Q1dyZVM1TzIweUorSTJhVHpWN0N6Q3ZGamlHTmRhMHczZlF5?=
 =?iso-2022-jp?B?M2MyR2JmazhjZFprYlNiK1dzb2RoU05CSjd3SDlQK0x4bzEyRG9oRjJY?=
 =?iso-2022-jp?B?b2FpSlVRRGRDNDBkdzhoQ1VITmU5bGNiRGdacERxdWwySHdYay9NRWll?=
 =?iso-2022-jp?B?eEVBRi9jcVV5UVExdlVqRXRnYWQ5TDh1U3l5cWg4VlhvcG0zejd1Vzgr?=
 =?iso-2022-jp?B?UFFPQkN6eWl2Q0k2MUYzS1B2Ty9FcUR1Z1UwWnJaZm0yaVF1M2ZFVEJv?=
 =?iso-2022-jp?B?WHFoOWRiQit3U2pCck8zL3pnTGFZZ25BOTJsL1c4ZnRKWmJVbjNjMXB1?=
 =?iso-2022-jp?B?OFYvVE5pd3UvNzZjdEpUV3VxQVM4VGhXa0FFUkV3TXg2VWs5NFMvbDR1?=
 =?iso-2022-jp?B?OWhvM29UMk9kOFkvVnNFQlc3NnJtMk1CK2ozUjVtVUMreEJLU214MTFO?=
 =?iso-2022-jp?B?MmcvUlIvMWRrMG9IQkZhQmE4WENVMkVkLzdoaHppNVN1M2lhT254UzZi?=
 =?iso-2022-jp?B?b1RaMlRmMUlzR2ZWZjlXeE9XYmVqdEpjUkJFc0lkRVFrZDRWSitwcUUr?=
 =?iso-2022-jp?B?R3RlTnplS0NMQUJOMnFpVEc1NTRQdGVLVERJcWNqREl5Ni9NT2FuSUhT?=
 =?iso-2022-jp?B?bTdRcWtsL1Q0bTFxeXdxOXVFaHdxMWtTNUVQOTN0NmY0TTNBSnlqNHo3?=
 =?iso-2022-jp?B?ZUs3RzY2WnNuZ0FsWkIxVDluWE1sMGtBSUFaUWptdEV5b1dMK0k4S2JT?=
 =?iso-2022-jp?B?aFRjSHBXa0RPbDRNak9NNlNRNkphUDJDcUhadkFTNjI0M1FvSkhLZlBF?=
 =?iso-2022-jp?B?ZUpHcDRURjhzWmlvQW1WUUIrQjZTRkJwWG00eWF5N0dUdmZSdC9zRi8r?=
 =?iso-2022-jp?B?UzhQNWlvejdXanl1R2NsY3NjL0xXdEw4em52OHJBRWpQZUUvOGNwdXlK?=
 =?iso-2022-jp?B?S1ozd2orbmVYR0owdUhTVGRKUGwxbEFaQnV0RW9pQWJmbmp1RjlDVHor?=
 =?iso-2022-jp?B?M2gyZ3pQWUpNak9nc3NxK1BaVjJMR3dqSGlqc1RMTVRSZ2YwMzh4NStx?=
 =?iso-2022-jp?B?UWF3dFgyblp0YUNOMnZVNThPa1ZvUVdPYkpoZFlENGRJTHRuM1FiOERK?=
 =?iso-2022-jp?B?TUZqa1kxenpjM1JNMi9WMVR0YUlvL09YcWdyOHhPR09mWnpXZTdYQmRU?=
 =?iso-2022-jp?B?d0hmaDZzQWd4ZXprd2pwcDVzWHFTQ2tBYkJ6VTZicHU1R1B3alRKdFRo?=
 =?iso-2022-jp?B?VGdYSzJtNUNHUWxWeHBwK0xnTkN6WEJ3RmRBMUV4WHdBY3ljNXRtZjBp?=
 =?iso-2022-jp?B?TXBtNFlkUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a453948a-00b2-47ef-e703-08de61fede05
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 02:00:40.7405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNfEN+CL1QWsA+Z1vJC0oxrG0ZvfwyEHqNKgge+O371zlDKPy4UjJA7YFUDml5z+RdzmIbl5p3iI0wElH7ipPA0LL26JaFmnh7TpXEvVk4IRf1Y8by36FrxUph0FBVjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 02:00:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21793

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Thursday, January 29, 2026 5:11 PM
> To: 'Ovidiu Panait' <ovidiu.panait.rb@renesas.com>;
> cip-dev@lists.cip-project.org; pavel@nabladev.com
> Subject: RE: [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > Sent: Wednesday, January 28, 2026 10:25 PM
> > To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> > nobuhiro(=1B$B4d=1B(B
> > =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwa=
matsu.x90@mail.toshiba>
> > Subject: [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
> >
> > Hi,
> >
> > This series adds TSU support for the Renesas RZ/V2H SoC.
> >
> > All patches, except for patch 4/11, were cherry-picked from mainline ke=
rnel.
> >
> > Patch 4/11 is needed to fix asynchronous aborts during unbind. See the
> > MSTOP series [1] for more details.
> >
> > [1]
> > https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.bezne
> > a.uj
> > @bp.renesas.com/
> >
> > Best regards,
> > Ovidiu
>=20
>=20
> I reviewed this series, looks good to me.
> I can applyt this patch if there are no other comments and no issues on C=
I.
>  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/22934150=
29
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Best regards,
>   Nobuhiro
>=20

Applied and pushed, thanks.

Best regards,
  Nobuhiro




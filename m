Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD45C0218F
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 09:57:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.15764.1738317429954958888
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 01:57:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=EDw2pG3A;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:MIME-Version;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1738317427;x=1739527027;bh=Ndiry
	55SrDJ+rxSnzBTaWI1tHWa6ljm5qv9Idc2cNnY=;b=EDw2pG3Aj/gUq6Kt42izoPz794jtvOLgmvF
	akQuM+YydssFlT/Duxo8+TzBUYFoMz7h9uyX2R3JS286EH4En0Mb97+LDbrNdeehATE/jHTs2cKOW
	vvodovTu//J06uEV1zcos6TUozwoBoMVeYnfiUyFkbGQjJupNT4+P9g6TX81yH1Gn7r2Y6LFCRLFc
	7yD+osnibLn4Iw/uvUlxyV32H7BwlIK6qDud1hhp6g5EkLxcrnFV/i31dQge85UE/TWsQV0qnNd4X
	YHzw0PgFyS42AhWxUtZxS+UB4+H2GTo8IR7ArhIDthKS/egbvWkF9+HVDL/ySN9GhxCWTX5CqWdw=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 50V9v7ue1856574; Fri, 31 Jan 2025 18:57:07 +0900
X-Iguazu-Qid: 2yAbpfLvF1Xy0wTER8
X-Iguazu-QSIG: v=2; s=0; t=1738317426; q=2yAbpfLvF1Xy0wTER8; m=QSpiOb3an1qhZApDA+zdB7SYf21pAyOkKnQaG1n9mbI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 50V9v5HP684725
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:57:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu0SZ3kCSmIjOS9PP7q1dNSQhsD1vCPSbQsmzQ5x9H1AW79xCublrU85Nyo0SLtmeZO52hztRzXcEMhugnbYhQvXOg/TXZ5wjz3eZHfAZsMxTUNT1446x8iDrcaiEZQQvE1wTLY+rgRd1KL5vpMV0kNsJYrwSeboL2RVldNppNR5EEaYHkXckmLYC7+WMhgwapNb9pmNaYBeUj+ZEV3tQbIPMSBgt3+DsKDNs68DwyuDDkyVWypE+601LdoE8jVDRJ5L1SHC1BthAYuw+O6Q0RrU81jcgg0zY8e/eC/2oIuhitdt6zrzrmP6RfGGItYb07kICf/X/g+2PcVPU6Q24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5oIuXjTTU82eNKB8uuZHdZOFtcJHvt9yA16Pt5igEY=;
 b=yE58UTSiA5Ln8LcVl0kZkxJC55en37dyyUzW9Jcv3KgrQW8Y/QOsz3yygM88q0MjOxGB4iA5A0Vl9vhnC2KxjgaMBIosLGReia6ERFNCNJCXy89+iuFvmHS1fkPWIhrUGEVI5o3hni03pnNmRRProLeRfDCu0vDmNDAjgvUAabMANNd2GqdF/SRIoh0Mh/5YMD5m3PzGLT087rDaIsKry8YXpGVXaX4mjcCnBpXM4+qJM7DfJ5Z+/v+WdCRIYaDIG7ggp3XRbU4MKpRayFacqU4yYQDnyz6oRPVOj/2ctwoESCLUZI9KYSzoezzT/N9WzHReyDZenMm0y8E1y0JVAQ==
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
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaAAkRe6gABlpKzgBe04HoAA8CxzMAAdclSAAAvSl9ABozn5EA==
Date: Fri, 31 Jan 2025 09:57:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB1138502709ED426B37B76CAD4E1E82@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz> <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5FPtY4aUHqMoL4w@duo.ucw.cz> <181D46DD0F426F98.25327@lists.cip-project.org>
In-Reply-To: <181D46DD0F426F98.25327@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|OS3PR01MB8018:EE_
x-ms-office365-filtering-correlation-id: 88bd0d37-f972-4654-858c-08dd41dd9d28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bjFrTWNzdi9sZmNHT2xFbDlOc0hjL0xRQVA0WHptWnRPYWtGOFRSWkxV?=
 =?iso-2022-jp?B?Q1JmUDFrSjN5Z01IQXV4SkNLeml3ZGEwQllOVGZLYW9CV1ExTHFrQ3lh?=
 =?iso-2022-jp?B?U2Zub2NWTVZPY3ZIbkhrbU9uUk1JSTBsYWhmSDFmTzA3S2lGVG13c0Vr?=
 =?iso-2022-jp?B?M3Z4Ui93S25GT2g0cUdLQzNlRXhxRFFmYUh2Ty85L1R5anA5OFVwL2lX?=
 =?iso-2022-jp?B?SjhzR1JRM2drRS9ONHFnMVd0MDY3Um9QMjhycDV1dm9zcTBiL0FJU2pI?=
 =?iso-2022-jp?B?UnNQNUdWNjVFNCt5SWp0R1ZFZXVPclppdUQ3R1NaZVZnRWpPaHhWTGxh?=
 =?iso-2022-jp?B?cFRtSlZlS24rTnM2Uk11S1dsY2xmQW5YdWg5Vkw5R1I1UHg0L1R3MHMy?=
 =?iso-2022-jp?B?QlRzb1dheStURGcrVXRCK0NxcUNYUk92MElaL3RldXJidm8yQkF3K0VF?=
 =?iso-2022-jp?B?ai8wNmtYeFhUN2lLZDhWalJESGtLaHNvVGZZMWVJTDUrQ0JucllwenlE?=
 =?iso-2022-jp?B?UmVlRjAyWHREOHk5MDdmRG9jMktGbHJRYXhBMS9MMDJqV2FuZyt4Z1lE?=
 =?iso-2022-jp?B?Yzl3bjU1SExkekk5UVUxUllyWE52M1VNdlVuTmlBSWtEU2FPcDE4ejhZ?=
 =?iso-2022-jp?B?ZkRkRDBJR2UwZisvT3JMY0JIUWlZaVRaS1padlZqSDhaN1JEaDZOTFZ1?=
 =?iso-2022-jp?B?QlowUHdhR2RWVUU3dVpkSDZndVZmLzdKWGN1RnNHWDRMNGZEbUNLNFJi?=
 =?iso-2022-jp?B?WHR4aTg5S2RRcm1CclFRRHJhWCtXbXlPT3B3WjBka2RMT2p4ZU8wSVcr?=
 =?iso-2022-jp?B?VlM1ZUMwZ1g1RkZpL0dPZk54bWp0c1ZnQ3JEeFN1Nm5FYjFCSmFEQ2xl?=
 =?iso-2022-jp?B?MDRwejZIOFRNVk8yWEFEdXEvdGNLZ2g0NW42L25qYmhLOTdSNXFPaVpT?=
 =?iso-2022-jp?B?QSt1cVRqTjVJd3J6UnhHdldSTXphUG44SWFpbEsycG1oY1ZHYk43Ukh5?=
 =?iso-2022-jp?B?TFZ4YnUxYVBKWWRLU2U5U3NZcENXMi9sSGM5N01WdVc0S3ZZdjVsZyt6?=
 =?iso-2022-jp?B?Q09XamlZMlJOSXp2NU9HUFlxbldZdEZEUXc5V2RCaFVabndNNGlTcHF4?=
 =?iso-2022-jp?B?MGhkclI3RlBsazNydGFkOTh5bTNNdUFlWjFEeG9LTE94TWd3Q1gxRkNl?=
 =?iso-2022-jp?B?UU8wOHBpd3hPcWxFWXczVjlBZ2RMQlQyUUhLS3FOSjRmN2gvMTJFcCsz?=
 =?iso-2022-jp?B?R29yVHhPbzduSEhsbXhicVpDb3FJRFN0YzRMUWRHT1Q5Zy9UdDRtd3hq?=
 =?iso-2022-jp?B?V3YyenJmK2s0TlZyWVl4Q0hra3JiR0x1WGpEcFhNRFEzSk5qRWM1cHpF?=
 =?iso-2022-jp?B?SEd5cHBpaVQ3emM5Lzh6SVh0cjVsYlZLOWUwcmFvbXJ4V0w4K09lVklI?=
 =?iso-2022-jp?B?YlBwdlVKVnU4Y1N2KzhzSGlWOXNoMzczZ082N1U2M2hHUjhUSjlsV05R?=
 =?iso-2022-jp?B?UGhyVnRRTjZlTTlob0ZwMFN1T2tTZ0E0SjN5UzV1ZWVzZnVISmxUWTZY?=
 =?iso-2022-jp?B?YVpTUWIwN29jYzZLR0hzN1hUaU83WTV2Zlg3MzBUaDBPOHRkd3ZSbStn?=
 =?iso-2022-jp?B?ZEJJUkc2WnppVVlNcmNBbng3RFVQREpMV29hUk1xUkhZejlMdkpZL1Nx?=
 =?iso-2022-jp?B?bEw1cG9YRENQSWd6aTZoVUkra0RaR2JzQk0yNkJRcHFDV25rSjQ3QThI?=
 =?iso-2022-jp?B?U0g2RlJJdkNMNXplamRpS0VzZGI3K2FwWVFmVUpRVDU5RDZUKzFMOHQw?=
 =?iso-2022-jp?B?T04yQUUvck5WdnN5NnJHL2twMFlqRDYvQUI5emRsRlNEWFVveXVoeWE4?=
 =?iso-2022-jp?B?RHdnY2c0NlFKU2JTL0VQWGZlZ2E2ZE0vdEE1R3ZFaUZOZTRDYjU3MWtJ?=
 =?iso-2022-jp?B?YXZqQ0VEcDkramkxQVdYUzdoTTFFazNRaXI3eXUvdUl1ZWFoZU85UTBL?=
 =?iso-2022-jp?B?YXlZTFVHWXR1L2NEblRaazI3amVXYVp6NUl4OUpuQTZhcy9rR002TVdB?=
 =?iso-2022-jp?B?N0x1TktVREFUbjk2c2lsYkhSRHFDNWkrVFVaU2IyYWoxYVN5US9wTXVD?=
 =?iso-2022-jp?B?eEQ1aFlIOTVpdTVOODdGakttZkFPRDBBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SkFibFJRVGw1TUlDSjBNVWxkY0NaQ2doR1dnUWo0MlM5QnJCL2tDNXpX?=
 =?iso-2022-jp?B?SXN1UnhLaG5BQnM0d093N2FTTXFEcjlqTFkwbU5SSEZrRUliQ1NVMFQ0?=
 =?iso-2022-jp?B?TGdXOC8xYUQxZ2tBVUswenU2T3l6YkRwRTl0bkQ0M2ptRUlUdGprTDNW?=
 =?iso-2022-jp?B?bWRHSnlZcU5jcGtOaFNVQzZraXJiYkpsdUkyTDBJU1IxZ2tMcEZpaGNx?=
 =?iso-2022-jp?B?NEF1bWZWSEE0WHRlVmZnNGlrd2J5ZXZLaUFNRTdQUExkaUJWRmVDVnZQ?=
 =?iso-2022-jp?B?WkRUZnQ1RHJXdGVPUkIzY3VaTno1N2VKTlM5V3l4ZG5EWHltTmI4Vmhp?=
 =?iso-2022-jp?B?SUxKSmdoVjdhVXNVcjhVRUJ3WnhWZVVnOWM5S1hqL1c1T1NGUFlKVkZy?=
 =?iso-2022-jp?B?eEN1UGhuMmNxTkhIbHpQcm53bm9jR1piTE9Rcm9sbU9LOVhMVHNyNmZm?=
 =?iso-2022-jp?B?RHp6Uy9ya1lxUHUxWGZWbEtpVWFoMVc1NzhkZTRUcWUvNlk2d1RFR1dW?=
 =?iso-2022-jp?B?V2E4RDJsNmhNeFlEMzlkQ0Rpcjk2RGd2bnJjRTBhY2wwd1dhR3lqYklZ?=
 =?iso-2022-jp?B?VGRyUjQwanM5cDBKdnJGVlR1SFNsdzlHdHRMMXhYNkxRaXhYbjVoOG0x?=
 =?iso-2022-jp?B?QTNXb2RWR2RSM3BTUEFWaVo2UmhRRzd6SHhaWUVodjd4ZnRKVXhwY1M4?=
 =?iso-2022-jp?B?RGtnSlNjVlZsTDQ3UllsUXpYOUhvczdxL3NubkVyTVZJblBuaE0rUmxG?=
 =?iso-2022-jp?B?UERhQ1JzbVQ2M3NyYlpWSGh2S1RJOGl1NTBvMXhYeSt4NEdHYUdXS0Fs?=
 =?iso-2022-jp?B?dncrNTFSaElrN1JGeVg4cVFLNFRWTk94bXkxZ2JWY0l4Z1RaaHZSVlJK?=
 =?iso-2022-jp?B?TGNTNkkyMUVWOE1DZ29GaTVQOHhyZDBDMjNIV3ZJQjRCWFFzVHdVVUFs?=
 =?iso-2022-jp?B?UUVKWkkzekFEa0VKV1lWcnp1VlNuNUNSSHZNZnB0OXJkUW5rY1I5cE5L?=
 =?iso-2022-jp?B?dC84bEc0V3lEY0k4dU9sWDA4MnIwY0hOQUlIWCtrZTI1UllQTkk1emNx?=
 =?iso-2022-jp?B?VlltUTFOQ0RUMjNyblpkWW8wcnZ4T0hNZ1lWN2VSZUd3bFN3Y2dQdlJr?=
 =?iso-2022-jp?B?OE5LT05pekZGdFpLVHR6SlM5eWFBYnF3Y1VOOWRhSVdabk9jUU9wNjQ0?=
 =?iso-2022-jp?B?QVdJanp0ekx2NGpJOHREZ1N0b2EveU9LQTdObW9KVm8vRkRacHlBby95?=
 =?iso-2022-jp?B?WGJYeWw2UzZjWnB4aGRQbUxQNWpGR2h0d2xuN2p3R2JkZXhOZnVrakR4?=
 =?iso-2022-jp?B?WlNJbzZxdlFKSWM0Uy8xWEdEdW5rSVBQeW1VTUxiQldZaUg1RVpWYXlR?=
 =?iso-2022-jp?B?eDQzL0lIRXgrQzdRWkd1ZTFoRkF3d3h3VGQ4QTlBbXhPZUNNeVkyUzh3?=
 =?iso-2022-jp?B?RjdwM3d0UnE1OHM0Z3p0MmJNREJDeUM2UHFXSS9yeHhUYW9ETm4xSWFH?=
 =?iso-2022-jp?B?SUhqN0RHS1VMZnlUOFBwRGZ4K1dLejJDeXVZNnJtS0tNb1hHeHFLWWdv?=
 =?iso-2022-jp?B?ZXdOTVV6YjQwZ2VhZDdhNE5pbFpBSjBDSlI0dDkwbHV4TElLZWpMUGlW?=
 =?iso-2022-jp?B?bXJoaVY5OEw0ZjhRWllFYzZGa3ZMQ2Y0RUhEWHlXVStnek9WMWlXZkY1?=
 =?iso-2022-jp?B?bkNVa05aNC9pR20zS2J4Uks5ZzdwS3FUUm1BbkdUcDc5VTkwYkltNXlY?=
 =?iso-2022-jp?B?R0FEaDVXSjhPZDVHVWgvMFR5ME5yblc2NW5nd2hFSUtCU3IvSUpJVlZO?=
 =?iso-2022-jp?B?YUluREhFL2twRFdHWVJnUnFZcUxYTUxHMHpEcjdOdTNsVFI2cjl2WXp3?=
 =?iso-2022-jp?B?SGpLellEMnVSbVhaRnJESTVPbi90NGlnNDR6SUpvcUM5WmlwRmQwN2xa?=
 =?iso-2022-jp?B?NkgrV3llb1dWWTR6Mk45bXhzV3JtTUN1U2pFL1hSUGxNVHBQbDRkcmZm?=
 =?iso-2022-jp?B?QURUZlFqQjFpUnUvZVdXWHFLVVV3clBraGkvZFJ2SUhjVUI5YlVjUGlT?=
 =?iso-2022-jp?B?Uy93cUxTc2RycWJtVWxCNlpNMmxkOTdmb0k4S1N6SVhHVW5oWURNRmEz?=
 =?iso-2022-jp?B?NjVwQTRiOWJnMFQ4SVZOblBpL3BEQ292NXR5VU4zM2crT3FhaWgwMkVr?=
 =?iso-2022-jp?B?SE5CUFg2L2QxcE9uQ1JjdGdydXhJMmorcmxmS3RFZTMxc3k3MGx6Z1N5?=
 =?iso-2022-jp?B?T1RCMGd5VkdEb0ZlcUxFU2hJN3J1ZmR0RXExOHl4cmVlVW54NU44eGJX?=
 =?iso-2022-jp?B?YytDWDBBN2xHRHJCUjFVZXBiU25GOW5ibHc9PQ==?=
Content-Type: multipart/mixed;
	boundary="_003_TYCPR01MB1138502709ED426B37B76CAD4E1E82TYCPR01MB11385jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bd0d37-f972-4654-858c-08dd41dd9d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 09:57:03.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrQPsk9kf1fDIptR8jnta8BvHrDwGKrP8S9mxovo12GVIzhpjYSEb3EOIV6EbY12YNhiLGsH6A74PyiBBJki/ZaF+aEuTssIrgZgPx7d6Zwqq71j+AjFqaRP6mBYi8wT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8018
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 09:57:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17716

--_003_TYCPR01MB1138502709ED426B37B76CAD4E1E82TYCPR01MB11385jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> (1) Apply 0001 - 0016 to v4.4-rt and v4.9-rt (but not acceptable for -cip=
-rt)
> (2) Implement another flag like "system_is_scheduling" above then apply i=
t to
> v4.4-rt and v4.9-rt (Again, no need to suggest (1)(2) to v4.14-rt or late=
r because
> SYSTEM_SCHEDULING is already there)
> [...]
> First, I'd like to make a draft of (2) then confirm the repeated WARNINGs=
 do
> NOT occur with that.

I have created the patches (2) based on your idea.
Please check the attachments then let me know if you have any comments.

I confirmed that the repeated WARNING never occurs with the v4.4-rt + the p=
atches.
(20,000 reboots on VM, 7,000 on x86 64bit machine)

If no comment, I'll send the patches to both cip-dev and -rt lists.

Best regards,
Kazu


--_003_TYCPR01MB1138502709ED426B37B76CAD4E1E82TYCPR01MB11385jp_
Content-Type: application/octet-stream;
	name="0001-init-Introduce-system_scheduling-flag-for-allocate_s.patch"
Content-Description: 
 0001-init-Introduce-system_scheduling-flag-for-allocate_s.patch
Content-Disposition: attachment;
	filename="0001-init-Introduce-system_scheduling-flag-for-allocate_s.patch";
	size=2507; creation-date="Fri, 31 Jan 2025 09:55:02 GMT";
	modification-date="Fri, 31 Jan 2025 09:57:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NjE4M2Y2NzM1MTcyNGMwYTI1NGY4MDZlOGY0OWYwYjk5ZWUyOWI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYXp1aGlybyBIYXlhc2hpIDxrYXp1aGlybzMuaGF5YXNoaUB0
b3NoaWJhLmNvLmpwPgpEYXRlOiBGcmksIDMxIEphbiAyMDI1IDE3OjU3OjEzICswOTAwClN1Ympl
Y3Q6IFtQQVRDSCAxLzJdIGluaXQ6IEludHJvZHVjZSBzeXN0ZW1fc2NoZWR1bGluZyBmbGFnIGZv
cgogYWxsb2NhdGVfc2xhYigpCgpCZXR3ZWVuIHY0LjE0LXJ0IGFuZCB2NS4xMC1ydCwgYWxsb2Nh
dGVfc2xhYigpIGlzIHJlc3BvbnNpYmxlIHRvIGVuYWJsZQpJUlEgYmVmb3JlIHJ1bm5pbmcgdGhl
IGZvbGxvd2luZyBzbGFiIGFsbG9jYXRpb24gZnVuY3Rpb25zIGlmCiAgICBzeXN0ZW1fc3RhdGUg
Pj0gU1lTVEVNX1NDSEVEVUxJTkcKSG93ZXZlciwgU1lTVEVNX1NDSEVEVUxJTkcgaXMgaW50cm9k
dWNlZFsxXSBpbiB0aGUgbWFpbmxpbmUgdjQuMTMgYW5kCml0J3Mgbm90IGNvbWZvcnRhYmxlIHRv
IGJhY2twb3J0IGFsbCByZWxhdGVkIGNoYW5nZXMgaW50byBvbGRlciBSVCBrZXJuZWxzCmZyb20g
ZnVuY3Rpb25hbCBjb21wYXRpYmlsaXR5IGFuZCBsb25nZXIgdGVybSBtYWludGVuYW5jZSBwZXJz
cGVjdGl2ZXMuCgpUaHVzLCBhcyBhbiBhbHRlcm5hdGl2ZSAoYnV0IG5vdC1tYWlubGluZWQpIHdh
eSwgaW50cm9kdWNlIGFuIGV4dHJhIGZsYWcKInN5c3RlbV9zY2hlZHVsaW5nIiB3aGljaCBiZWNv
bWVzIHRydWUgYXQgdGhlIHNhbWUgcG9pbnQgYXMKICAgIHN5c3RlbV9zdGF0ZSA9IFNZU1RFTV9T
Q0hFRFVMSU5HCmluIHRoZSBtYWlubGluZSBzbyB0aGF0IHRoZSBleGlzdGluZyBzeXN0ZW1fc3Rh
dGVzIGFuZCB1c2VycyBvZiB0aGVtCmFyZSBub3QgYWZmZWN0ZWQuCgphbGxvY2F0ZV9zbGFiKCkg
d2lsbCB1c2UgdGhpcyBmbGFnIGZvciBpdHMgSVJRIGNvbnRyb2wgYnkgdGhlIHVwY29taW5nIGNo
YW5nZS4KClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxNzA1MTYxODQyMzEuNTY0
ODg4MjMxQGxpbnV0cm9uaXguZGUvCgpTaWduZWQtb2ZmLWJ5OiBLYXp1aGlybyBIYXlhc2hpIDxr
YXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPgotLS0KIGluY2x1ZGUvbGludXgva2VybmVs
LmggfCAgMSArCiBpbml0L21haW4uYyAgICAgICAgICAgIHwgMTIgKysrKysrKysrKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2tlcm5lbC5oIGIvaW5jbHVkZS9saW51eC9rZXJuZWwuaAppbmRleCBkNjhmNjM5ZjczMzAuLjJh
MTVlODI5YWFlYyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9rZXJuZWwuaAorKysgYi9pbmNs
dWRlL2xpbnV4L2tlcm5lbC5oCkBAIC00OTAsNiArNDkwLDcgQEAgZXh0ZXJuIGVudW0gc3lzdGVt
X3N0YXRlcyB7CiAJU1lTVEVNX1JFU1RBUlQsCiAJU1lTVEVNX1NVU1BFTkQsCiB9IHN5c3RlbV9z
dGF0ZTsKK2V4dGVybiBib29sIHN5c3RlbV9zY2hlZHVsaW5nOwogCiAjZGVmaW5lIFRBSU5UX1BS
T1BSSUVUQVJZX01PRFVMRQkwCiAjZGVmaW5lIFRBSU5UX0ZPUkNFRF9NT0RVTEUJCTEKZGlmZiAt
LWdpdCBhL2luaXQvbWFpbi5jIGIvaW5pdC9tYWluLmMKaW5kZXggOTkzM2ZjYTNhNWM4Li5iNTM1
NmE4NzBlN2YgMTAwNjQ0Ci0tLSBhL2luaXQvbWFpbi5jCisrKyBiL2luaXQvbWFpbi5jCkBAIC0x
MTAsNiArMTEwLDE0IEBAIGJvb2wgZWFybHlfYm9vdF9pcnFzX2Rpc2FibGVkIF9fcmVhZF9tb3N0
bHk7CiBlbnVtIHN5c3RlbV9zdGF0ZXMgc3lzdGVtX3N0YXRlIF9fcmVhZF9tb3N0bHk7CiBFWFBP
UlRfU1lNQk9MKHN5c3RlbV9zdGF0ZSk7CiAKKy8qCisgKiB0cnVlIGlzIGVxdWFsIHRvIHN5c3Rl
bV9zdGF0ZSA+PSBTWVNURU1fU0NIRURVTElORyBpbiB0aGUgbWFpbmxpbmUuCisgKiBPbiBQUkVF
TVBUX1JUIGtlcm5lbHMsIHNsYWIgYWxsb2NhdG9yIHJlcXVpcmVzIHRoaXMgc3RhdGUgdG8gY2hl
Y2sgaWYKKyAqIHRoZSBhbGxvY2F0aW9uIG11c3QgYmUgcnVuIHdpdGggSVJRIGVuYWJsZWQgb3Ig
bm90LgorICovCitib29sIHN5c3RlbV9zY2hlZHVsaW5nIF9fcmVhZF9tb3N0bHkgPSBmYWxzZTsK
K0VYUE9SVF9TWU1CT0woc3lzdGVtX3NjaGVkdWxpbmcpOworCiAvKgogICogQm9vdCBjb21tYW5k
LWxpbmUgYXJndW1lbnRzCiAgKi8KQEAgLTQwMSw2ICs0MDksMTAgQEAgc3RhdGljIG5vaW5saW5l
IHZvaWQgX19pbml0X3JlZm9rIHJlc3RfaW5pdCh2b2lkKQogCXJjdV9yZWFkX2xvY2soKTsKIAlr
dGhyZWFkZF90YXNrID0gZmluZF90YXNrX2J5X3BpZF9ucyhwaWQsICZpbml0X3BpZF9ucyk7CiAJ
cmN1X3JlYWRfdW5sb2NrKCk7CisKKwkvKiBDb3JyZXNwb25kcyB0byBzeXN0ZW1fc3RhdGUgPSBT
WVNURU1fU0NIRURVTElORyBpbiB0aGUgbWFpbmxpbmUgKi8KKwlzeXN0ZW1fc2NoZWR1bGluZyA9
IHRydWU7CisKIAljb21wbGV0ZSgma3RocmVhZGRfZG9uZSk7CiAKIAkvKgotLSAKMi4zMC4yCgo=

--_003_TYCPR01MB1138502709ED426B37B76CAD4E1E82TYCPR01MB11385jp_
Content-Type: application/octet-stream;
	name="0002-mm-slub-allocate_slab-enables-IRQ-right-after-schedu.patch"
Content-Description: 
 0002-mm-slub-allocate_slab-enables-IRQ-right-after-schedu.patch
Content-Disposition: attachment;
	filename="0002-mm-slub-allocate_slab-enables-IRQ-right-after-schedu.patch";
	size=4569; creation-date="Fri, 31 Jan 2025 09:55:02 GMT";
	modification-date="Fri, 31 Jan 2025 09:57:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZDNiNjExNGQ1YjQ4MDQwYThiY2RlN2E2NDQ0M2MyN2NhNTI5MDJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYXp1aGlybyBIYXlhc2hpIDxrYXp1aGlybzMuaGF5YXNoaUB0
b3NoaWJhLmNvLmpwPgpEYXRlOiBGcmksIDMxIEphbiAyMDI1IDE3OjU4OjQyICswOTAwClN1Ympl
Y3Q6IFtQQVRDSCAyLzJdIG1tOiBzbHViOiBhbGxvY2F0ZV9zbGFiKCkgZW5hYmxlcyBJUlEgcmln
aHQgYWZ0ZXIKIHNjaGVkdWxlciBzdGFydHMKClRoaXMgcGF0Y2ggcmVzb2x2ZXMgdGhlIHByb2Js
ZW0gaW4gNC40ICYgNC45IFBSRUVNUFRfUlQga2VybmVscyB0aGF0CnRoZSBmb2xsb3dpbmcgV0FS
TklORyBoYXBwZW5zIHJlcGVhdGVkbHkgZHVlIHRvIGJyb2tlbiBjb250ZXh0CmNhdXNlZCBieSBy
dW5uaW5nIHNsYWIgYWxsb2NhdGlvbiB3aXRoIElSUSBkaXNhYmxlZCB1bmludGVuZGVkbHkuCgpX
QVJOSU5HOiBDUFU6ICogUElEOiAqKiBhdCAqL2tlcm5lbC9jcHUuYzoxOTcgdW5waW5fY3VycmVu
dF9jcHUrMHg2MC8weDcwKCkKClRoZSBzeXN0ZW0gaXMgYWxtb3N0IHVucmVzcG9uc2l2ZSBhbmQg
dGhlIGJvb3Qgc3RhbGxzIG9uY2UgaXQgb2NjdXJzLgpUaGlzIHJlcGVhdGVkIFdBUk5JTkcgb25s
eSBoYXBwZW5zIHdoaWxlIGtlcm5lbCBpcyBib290aW5nCihiZWZvcmUgcmVhY2hlcyB0aGUgdXNl
cmxhbmQpIHdpdGggYSBxdWl0ZSBsb3cgcmVwcm9kdWNpYmlsaXR5OgpPbmx5IG9uZSB0aW1lIGlu
IGFyb3VuZCAxLDAwMCB+IDEwLDAwMCByZWJvb3RzLgoKW1Byb2JsZW0gZGV0YWlsc10KCk9uIFBS
RUVNUFRfUlQga2VybmVscyA8IHY0LjE0LXJ0LCBhZnRlciBfX3NsYWJfYWxsb2MoKSBkaXNhYmxl
cwpJUlEgd2l0aCBsb2NhbF9pcnFfc2F2ZSgpLCBhbGxvY2F0ZV9zbGFiKCkgaXMgcmVzcG9uc2li
bGUgdG8KcmUtZW5hYmxlIElSUSBvbmx5IHVuZGVyIHRoZSBzcGVjaWZpYyBjb25kaXRpb25zOgoK
KDEpIGdmcGZsYWdzX2FsbG93X2Jsb2NraW5nKGZsYWdzKSBPUgooMikgc3lzdGVtX3N0YXRlID09
IFNZU1RFTV9SVU5OSU5HCgpUaGUgcHJvYmxlbSBoYXBwZW5zIHdoZW4gKDEpIGlzIGZhbHNlIEFO
RCBzeXN0ZW1fc3RhdGUgPT0gU1lTVEVNX0JPT1RJTkcKY2F1c2VkIGJ5IHRoZSBmb2xsb3dpbmcg
c2NlbmFyaW86CgoxLiBTb21lIGtlcm5lbCBjb2RlcyBpbnZva2UgdGhlIGFsbG9jYXRvciB3aXRo
b3V0IF9fR0ZQX0RJUkVDVF9SRUNMQUlNCiAgIGJpdCAoaS5lLiBibG9ja2luZyB1bmFsbG93ZWQp
IHdoaWxlIFNZU1RFTV9CT09USU5HCjIuIGFsbG9jYXRlX3NsYWIoKSBjYWxscyB0aGUgZm9sbG93
aW5nIGZ1bmN0aW9ucyB3aXRoIElSUSBkaXNhYmxlZAozLiBidWZmZXJlZF9ybXF1ZXVlKCkgaW52
b2tlcyBsb2NhbF9bc3Bpbl9dbG9ja19pcnFzYXZlKHBhX2xvY2spIHdoaWNoCiAgIG1pZ2h0IGNh
bGwgc2NoZWR1bGUoKSBhbmQgZW5hYmxlIElSUSBpZiBmYWlsZWQgdG8gZ2V0IHBhX2xvY2sKNC4g
VGhlIG1pZ3JhdGVfZGlzYWJsZSBjb3VudGVyLCB3aGljaCBpcyB1bmludGVuZGVkIHRvIGJlIHVw
ZGF0ZWQgd2hpbGUKICAgSVJRIGRpc2FibGVkLCBpcyBhY2NpZGVudGFsbHkgdXBkYXRlZCBhZnRl
ciBzY2hlZHVsZSgpIHRoZW4KICAgbWlncmF0ZV9lbmFibGUoKSByYWlzZXMgV0FSTl9PTl9PTkNF
KHAtPm1pZ3JhdGVfZGlzYWJsZSA8PSAwKQo1LiBUaGUgdW5waW5fY3VycmVudF9jcHUoKSBXQVJO
SU5HIGlzIHJhaXNlZCBldmVudHVhbGx5IGJlY2F1c2UgdGhlCiAgIHJlZmNvdW50IGNvdW50ZXIg
aXMgbGlua2VkIHRvIHRoZSBtaWdyYXRlX2Rpc2FibGUgY291bnRlcgoKVGhlIGJlaGF2aW9yIDIt
NSBhYm92ZSBoYXMgYmVlbiBjZXJ0YWlubHkgb2JzZXJldmVkWzFdIHVzaW5nIGZ0cmFjZS4KVGhl
IGNvbmRpdGlvbiAoMikgYWJvdmUgbWF5IGludGVuZCB0byBtYWtlIHRoZSBtZW1vcnkgYWxsb2Nh
dG9yIGZ1bGx5CnByZWVtcHRpYmxlIG9uIFBSRUVNUFRfUlQga2VybmVsc1syXSwgc28gdGhlIGxv
Y2sgZnVuY3Rpb24gaW4gdGhlCnN0ZXAgMyBhYm92ZSBzaG91bGQgd29yayBpZiBTWVNURU1fUlVO
TklORyBidXQgbm90IGlmIFNZU1RFTV9CT09USU5HLgoKW0hvdyByZXNvbHZlZCBpbiBuZXdlciBS
VCBrZXJuZWxzXQoKQSBwYXRjaCBzZXJpZXMgaW4gdGhlIG1haW5saW5lICh2NC4xMykgaW50cm9k
dWNlcyBTWVNURU1fU0NIRURVTElOR1szXS4KT24gdG9wIG9mIHRoaXMsIHY0LjE0LXJ0ICg2Y2Vj
ODQ2NykgY2hhbmdlcyB0aGUgY29uZGl0aW9uICgyKSBhYm92ZToKCi0gICAgICAgaWYgKHN5c3Rl
bV9zdGF0ZSA9PSBTWVNURU1fUlVOTklORykKKyAgICAgICBpZiAoc3lzdGVtX3N0YXRlID4gU1lT
VEVNX0JPT1RJTkcpCgpUaGlzIGF2b2lkcyB0aGUgcHJvYmxlbSBieSBlbmFibGluZyBJUlEgYWZ0
ZXIgU1lTVEVNX1NDSEVVTERJTkcuClRodXMsIHRoZSBjb25kaXRpb25zIHRoYXQgYWxsb2NhdGVf
c2xhYigpIGVuYWJsZXMgSVJRIGFyZSBsaWtlOgoKKDIpc3lzdGVtX3N0YXRlICAgdjQuOS1ydCBv
ciBiZWZvcmUgIHY0LjE0LXJ0IG9yIGxhdGVyClNZU1RFTV9CT09USU5HICAgICAgICAoMSk9PXRy
dWUgICAgICAgICAgKDEpPT10cnVlCiAgICAgICAgICAgICAgICAgICAgICAgICAgOiAgICAgICAg
ICAgICAgICAgIDoKICAgICAgICAgICAgICAgICAgICAgICAgICA6ICAgICAgICAgICAgICAgICAg
dgpTWVNURU1fU0NIRURVTElORyAgICAgICAgIDogPCBQcm9ibGVtICAgICAgQWx3YXlzCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgdiA8IG9jY3VycyBoZXJlICAgIHwKU1lTVEVNX1JVTk5JTkcg
ICAgICAgICAgQWx3YXlzICAgICAgICAgICAgICAgfAogICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICB8CiAgICAgICAgICAgICAgICAgICAgICAgICAgdiAgICAgICAg
ICAgICAgICAgIHYKCltIb3cgdGhpcyBwYXRjaCB3b3Jrc10KCkFuIHNpbXBsZSBvcHRpb24gaXMg
dG8gYmFja3BvcnQgdGhlIHNlcmllc1szXSwgd2hpY2ggaXMgcG9zc2libGUKYW5kIGhhcyBiZWVu
IHZlcmlmaWVkWzRdLiBIb3dldmVyLCB0aGUgc2VyaWVzIHB1bGxzIG11bHRpcGxlIGtpbmRzIG9m
CmZ1bmN0aW9uYWwgY2hhbmdlcyBsaWtlIFNZU1RFTV9TQ0hFRFVMSU5HIGFuZCBhZGp1c3RtZW50
cyBmb3IgaXQsCmVhcmx5IG1pZ2h0X3NsZWVwKCkgYW5kIHNtcF9wcm9jZXNzb3JfaWQoKSBzdXBw
b3J0cywgZXRjLgpUaGVyZWZvcmUsIHRoaXMgcGF0Y2ggdXNlcyBhbiBleHRyYSAoYnV0IG5vdCBt
YWlubGluZWQpIGZsYWcKInN5c3RlbV9zY2hlZHVsaW5nIiBwcm92aWRlZCBieSB0aGUgcHJpb3Ig
cGF0Y2ggaW5zdGVhZCBvZgppbnN0cm9kdWNpbmcgU1lTVEVNX1NDSEVEVUxJTkcsIHRoZW4gdXNl
IHRoZSBzYW1lIGNvbmRpdGlvbiBhcwpuZXdlciBSVCBrZXJuZWxzIGluIGFsbG9jYXRlX3NsYWIo
KS4KClRoaXMgcGF0Y2ggYWxzbyBhcHBsaWVzIHRoZSBmaXggaW4gdjUuNC1ydCAoN2FkZjViYzUp
IHRvIGNhcmUKU1lTVEVNX1NVU1BFTkQgaW4gdGhlIGNvbmRpdGlvbiBjaGVjay4KClsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvVFlDUFIwMU1CMTEzODVFM0NERjA1NTQ0QjYzRjdFRjlD
MUUxNjIyQFRZQ1BSMDFNQjExMzg1LmpwbnByZDAxLnByb2Qub3V0bG9vay5jb20vClsyXSBodHRw
czovL2RvY3Mua2VybmVsLm9yZy9sb2NraW5nL2xvY2t0eXBlcy5odG1sI3Jhdy1zcGlubG9jay10
LW9uLXJ0ClszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxNzA1MTYxODQyMzEuNTY0
ODg4MjMxQGxpbnV0cm9uaXguZGUvVC8KWzRdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9U
WUNQUjAxTUIxMTM4NTc5Q0E3NjEyQjU2OEJCODgwNjUyRTEyNzJAVFlDUFIwMU1CMTEzODUuanBu
cHJkMDEucHJvZC5vdXRsb29rLmNvbS8KClNpZ25lZC1vZmYtYnk6IEthenVoaXJvIEhheWFzaGkg
PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+Ci0tLQogbW0vc2x1Yi5jIHwgMyArKy0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9tbS9zbHViLmMgYi9tbS9zbHViLmMKaW5kZXggZmQyM2ZmOTUxMzk1Li42MTg2YTI1ODYy
ODkgMTAwNjQ0Ci0tLSBhL21tL3NsdWIuYworKysgYi9tbS9zbHViLmMKQEAgLTE0MTIsNyArMTQx
Miw4IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqYWxsb2NhdGVfc2xhYihzdHJ1Y3Qga21lbV9jYWNo
ZSAqcywgZ2ZwX3QgZmxhZ3MsIGludCBub2RlKQogCWlmIChnZnBmbGFnc19hbGxvd19ibG9ja2lu
ZyhmbGFncykpCiAJCWVuYWJsZWlycXMgPSB0cnVlOwogI2lmZGVmIENPTkZJR19QUkVFTVBUX1JU
X0ZVTEwKLQlpZiAoc3lzdGVtX3N0YXRlID09IFNZU1RFTV9SVU5OSU5HKQorCS8qIFNZU1RFTV9T
Q0hFRFVMSU5HIDw9IHN5c3RlbV9zdGF0ZSA8IFNZU1RFTV9TVVNQRU5EIGluIHRoZSBtYWlubGlu
ZSAqLworCWlmIChzeXN0ZW1fc2NoZWR1bGluZyAmJiBzeXN0ZW1fc3RhdGUgPCBTWVNURU1fU1VT
UEVORCkKIAkJZW5hYmxlaXJxcyA9IHRydWU7CiAjZW5kaWYKIAlpZiAoZW5hYmxlaXJxcykKLS0g
CjIuMzAuMgoK

--_003_TYCPR01MB1138502709ED426B37B76CAD4E1E82TYCPR01MB11385jp_--



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F43C61DA4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 07:31:39 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.50])
 by mx.groups.io with SMTP id smtpd.web10.7901.1678347091364481439
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Mar 2023 23:31:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NuXzRc42;
 spf=pass (domain: siemens.com, ip: 40.107.104.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLcRabN5DWAO1GWeA8vbqlVNuFa3VOn6GRtxSBev9MJ03ljfKgthfMakBSnkwblZviJcVBQKicQZl4hB8QYYaDBn2ZMK5SU1LqwbavCgZ/2EJAb+562A3UzEhIWlMDgLbJL16zjisKBN1Qcl2ht28X1sHzpEUv0RE0O7CSqQNJhF5EP1k2UIZyGHkCnmId9+9pMWMfct9yBQOW02i4kgKfz9Tx4LBq3PJZz1r2Ok78kLtqim4rpM8ZE5y7OoprR7xj494/BsRqQ/m08rcsD3lMOgGRvMEWM6RIXGAjQ7sTJx9qKvNGwkZNmspZ9LA7epZChwMf/npXdHF4DNYGOurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqPpAc+5oN7ZWsXc0lCwPNGafINj11Pb6gb6yQqTFOw=;
 b=jdUv+8c/mrPkYgqQypkJ06YYCcFCpgsZH8FF5ycqkGnZj+AfOWRoP+LmBCWT1AgCUYH7T9Pa1Bp5wynKIGztMMNaw7pYjR/tcJU+i7w2iD2T7OV01CSBw7ftQFO4nuaHYpr+/VrQ+vxsi/LAaMRkYl6ud5fSWzasee+WwlLJcU87R774sQLoI3piIkSG/P9JB1gZRs0JtKR3EnHbDLTuRFDpl/YwxX+0lAvsTzf3opbMLslgsC963JGk8In/u5UbzJj+Sqsq0dSEzN0TTljTxYWftDFGAQRAsDBl2nIbMLFx7j4QfNGAWlNOjI0BHtXdUdX9fmO2EkkN8+So02n0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqPpAc+5oN7ZWsXc0lCwPNGafINj11Pb6gb6yQqTFOw=;
 b=NuXzRc42nNAz4vN3/uCf9jeiEBaFTxkLEyszxb2Kcb8BhYfHjtolhuMJTnH10AcEzpT1u9x2O5fXjuwymuewp96GlV2XRgVTbuk53Ghnp3H1T/156ljm4ywHKExJod9cL3eS3aO3tsS/992lS49lkYlwPWh6OyZ3y/UsbkhDLs/ydZRHu9I57QyDKa5sUbxkATuZPE+GEKZqDCVl7VsLo62WUqJ+h2rWbFZ3ky1l+CLFdlOZEZgyZTSpSttNMj1oyXYIa+DUSRi2nnVMtClAWSoq74B7QPPj9IUWPA0h2Rg7grUF5td1HLLwUez+nAn30bBCIbjElSiiNDEBcXylNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:524::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Thu, 9 Mar
 2023 07:31:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.016; Thu, 9 Mar 2023
 07:31:28 +0000
Message-ID: <a1cbefb6-26d9-1217-1811-290f06394859@siemens.com>
Date: Thu, 9 Mar 2023 08:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: aae78571-9422-49d1-d0c6-08db20704bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8AZx1rkbi4nMf6TFyCBETFuiczYvPj4arnWNaZszMYUBPpQq3Naeb1c9Y0f2EJZJ2xtlwi+hV0ZZ8docUu/ZFBMAnCQwy9qPEhp5dZsb6oVXGLlDOLUKON8sZKLwgZ+rhd2VQJK/C6g9wrtPZHdnKS8l0sxz//H8zPNEQyAOh3t9Onhl+fOuTK/7oIYJyDcvLMw89UuIKO+9PS3Noa8IJNGkT8PzhpRuQkliCUGmKYI30WIRC+RaCsNFVWq2p6z3Qe5mWcnQledtDDr84jRt2yajD7TGgFnV41Ec/SpUbVxTJQjEqehaRnRfitWyygDMCPXlzQGUKnPPQZf3GQnmfnBAko4qZhqs+fmeg7uNcuYNLwJY9g90xCKMcoLlPff4wYHnyh54ksQNpILb5BHg8uJjPcKfGEN1pApEXTqx9erLwVVkQ0Q4k8G15GcMLb6R/HTleHTknW/yjJE4FCBoUBYZB4H4CXBdGmwZO1WhoIISeEyDrMk049qlABuDPhcm//C6QMUvRwECYvwUeSeY+QRl5Fw1PfyCBBzOk2q3qMkx/xCi3uWiI3hQvJFm+V090VRE0OuhyquJ26YHFOFAHE51+geWrh1QiFlJ3k8p5eJnU9NJwPVwooTyuD+6blMMF9zdAqfkzrGVop5xqi8jSKAd/cjUl8n/S/0BtJgdFFe+xi8D5WYTnFj5t1UTU+oi4NPu7V8JGS509DQMtHkLTLCEWCwNCRydkajn/6fFMOrQBW06LLNKwc8Thv+Blhc7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(36756003)(316002)(5660300002)(6486002)(966005)(4744005)(478600001)(8936002)(66946007)(66556008)(6916009)(8676002)(44832011)(66476007)(2906002)(41300700001)(82960400001)(26005)(6512007)(31696002)(186003)(38100700002)(83380400001)(2616005)(6506007)(6666004)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFVScG9RT3Y4Q213V00rWm9BWlVISkJEcllpVDJjOW9GU0xvdmsrakl3RGJl?=
 =?utf-8?B?NGpEWkRlS1Urb0wwcGpVNkpnTldWb1dDOFRiM21rQWpXVzlpZm9RWTdxc0h6?=
 =?utf-8?B?WnhHZkVtUVNPU0NFVEFDNUt3cHdnNUdnR0xTc3N5UzJ5Rlo3TmdiM0Z0K2wv?=
 =?utf-8?B?YTV4T1BBc0E4NTJ4bUpyVWRBV0phYnVjVmV3ZXQyMENHSVNKMnZuNEVFOXAr?=
 =?utf-8?B?ZDN2OStQVXd5S3F0ZEtUVnQvKzBjcXhMaVBzczNHcFQ5MHFsRnBzZUJZMXVo?=
 =?utf-8?B?bk1sbDF5SGhTVWFTNUVrQ0szM3FtdWZVb2Z0cGNhNkEreWlPTkNRUkc2USs2?=
 =?utf-8?B?Sm9pQTVrN0paZ0xkMDgrMHE2TkpiMnRBQ1JESGUrVzlHUE5XTVBteXlseDRI?=
 =?utf-8?B?c2VUMHZGUWYwYTFjWGhMVnBXdi8vSDJmdFF6Rm1UcWtvTkZZaU1JVGRaYWhp?=
 =?utf-8?B?SjlEQXB2VmpRRlVmcU1DdnBabjM5bVdra2lpM3d1V1I4OHhDM1k0Z2FuUFhu?=
 =?utf-8?B?R05sYi9RSjdvOGl3U2w0dGM0TWJ2REpVbTBoZ1N5dXYrQlZlRmRVN0Zhdko2?=
 =?utf-8?B?ckljMllhNjFQL2pNQmlxaERRVFo1RHFxSnZnWUZQOGs5RFNISit5TmRLNVBa?=
 =?utf-8?B?dGZWU3N4MDNhdGtCZG1SQ1RXUFQ4UkgvWjNvby9Fay9GNTFmR0ZwR0NqWWFt?=
 =?utf-8?B?WjVqWDJHd2dqY2tSZlg4citBYWc1byt2aUFhYzJGMXlMV29QRHZBT1p1bkFz?=
 =?utf-8?B?U0VxVjlFd3d1cmY2VVhRaE15cTdqTWdZeFRuWUl4dm1ZZTVYWi9FUXRwa0VN?=
 =?utf-8?B?SUVVOUZPT3lLbExJV3V2NENzWVl2Nmh5UWk3MGl2MEJpUWRCaW9DSHl4amND?=
 =?utf-8?B?a3VxU1lTc01JVFNmMnVxektKZTJuOXN5b2l1bXFBVjhVK0h0cmJlQ3NnRU5L?=
 =?utf-8?B?dG92ZXZQdjBITnhaWkpvTnd2eGdrblprdHdTU0loWGxibDFBeXdJSnh3M051?=
 =?utf-8?B?RTFJMWtjVEZwT0UwYzdNTUllYmtVT3pJM1JaUjFSYStUNHBpZmw2TUpJMHlK?=
 =?utf-8?B?TDJvVURQVzBSWjA3d3dGUldYdTJTa0xlWWNpcWFnR2JYZUNsdC9aU1h3ckQx?=
 =?utf-8?B?ZjVPRk5tVGd2VkpMeXp6ZUlxeGc3b2RsS1dnVUxoR2oxN1QwdDZHRTd4WEdu?=
 =?utf-8?B?WnBiREFBcFJ4elkrLy85ZGxuMmlWZEpmR0JYWmY2d2lBQktsbTlzd3BpakxU?=
 =?utf-8?B?WWFnK1oySUR3ZHJtS2hEejBWMG1qRy92Z2xCTE5GZ0Z2cGhINy9VNVljZ3hi?=
 =?utf-8?B?NkNOS2Y0RUVsdURaeXYvUVZWWDNYeHRQNGI3d2FpUEpraVBPcWprS1dCcC9O?=
 =?utf-8?B?SDc2ek1VdXNpL3VIS0NhdVYxZFZXUzBrcXdoWmYrZlhyMWhQdzRBTzJqZEVs?=
 =?utf-8?B?OW91K2ZKWGZnZkJyN3puWUczN3lXVGRSNEFGc2ZYSzQ3TU9rVUtFaEpjWjBl?=
 =?utf-8?B?NGV6dXlCOUN5eEcyVW5WdDFTRm5hLzFteHhGQmF2SXN0TUdPR3RzVGZwZzdK?=
 =?utf-8?B?NndTV0FnUlpoMWZKN1lEU2VPdmRUUU1HTXp6TytPUGpNVWpDMGhLYTFUWFRy?=
 =?utf-8?B?c2NRamdqMTVpalJRbkZCSlJLWTQwREhqRDRaQVRXbHJxTUZyc1lXV0Q4Yzln?=
 =?utf-8?B?b0dORmk1MXQxV0h4UUVDK01tV3hMeE8zN1Y4c3pLRHhsU2ZYYWo2YUNSQXl5?=
 =?utf-8?B?bWNQTTNJV1VYUzRUOElRSHNXSUZYTVNWV1RvRG92OVRkNmYzNHp4VEpXTzlS?=
 =?utf-8?B?YTU5YjhlZ01CUjB2UXZWd2xFT0NKMllKY2xtUW1ZS085U0ZsWUhCN2xIZ0cr?=
 =?utf-8?B?TFI5Tnk4YjBYTlJwMzZBRDcvb3ZJNFdaL05LWGl0d2JrNlpNY2N4em9sMjNq?=
 =?utf-8?B?UUY1SFp4T3cvdUVKT1hYYllnMnRuMUdwL1N2WkdVQzBkOFdLa01QMFhqL0lm?=
 =?utf-8?B?OUNGVHhzSW9jVW1kb1EzT1RUdGJIcjFtRTJPZk1kcTF0dUYxTjloeTVjZFpl?=
 =?utf-8?B?Tm81dm1aNGxEaS8waDhRczErOGlSVGlHbEVVZXk4cksxSmZ0MENYZEJSZmtm?=
 =?utf-8?B?cGhINzZpUXgxbTVlbDdKR3VJZFBjeGQxVmhJQ296cUp1VEpLYWcyWVI4b256?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae78571-9422-49d1-d0c6-08db20704bc7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:31:28.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjYpNUyjYtvBWx7c9ni6ffrD6SLwz5YHvjPdkky2p+GFRUTssJ7Khyn756po3qFBNJbDfrG8g0p+1/aXvqc5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 07:31:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10954

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=3&day=9&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/03/cip.2023-03-02-13.03.log.html

* Action items
  1. enable more stable trees for testing (patersonc)
  2. report 6.1 test plan to LKML (pavel, depends on 1.)
  3. clarify usage of .sources files in cip-kernel-config (patersonc)
  4. reach out to Greg regarding LTS (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan


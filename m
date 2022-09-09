Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2CECAAD3
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 17:37:07 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.45])
 by mx.groups.io with SMTP id smtpd.web09.695.1662745022731826599
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 10:37:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=pZnLfMDo;
 spf=pass (domain: siemens.com, ip: 40.107.21.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWLlC90jVtVuAXMUMcAie54HqmEt3x41WzxjZQMiln9a4sgc2bKQ4DYGOLbSdKSeUmKv3p+rCPAA8WybvOEQ5Q3IG7W3NBrsVyLF8+bu9bw3paD91BuNS7rF9Dq93VRfJWKZv1CuXi7Vq0jQoentLuAWhbJKnIWGVdImqkb0Gt+Xb8Wxaf8labrNRXNnaFGhKgJvOlfC1l+EUxplIpCHXZm4etlyAJJvk+NZ4fMrYibutXQNmS43QWcZxhWMNCbYgV5ONsFf27SzRmdyoTkPtwnBsY/U9uclFYaeQBcEAfn0JbIk2LpgezJ3iVVXP9bpQ7uCTNLb3StToPiIYtlxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAXtdF1rbpyqRsCIlkm3A2eSMhGFSIqLIIi96xpxC2Y=;
 b=Z6172/MeB5jn7uV5NZ1NW71DawRz9UFFeA//siLQSJ3YE6uK3uP/ORSaoJZPFB1tGiWDqAnvG7wlSw5uKCFr1/RjoVzHB5Dh6IEo0fSFYX5weXzA0SyQwpcshFVSCFl93bpV6A+y3GEQg3Ua6az8XkWZ6ZPgkueRhCXDK3qaa649dLwkSu0WrJwzcKWyPtpiT1LaZ6GUSFccWHc5rOBFTd6CbmN/i32EEQj7sK37xyviUfXASzU69N4tYplZey5N7iXpkYPCutbARQ7aDfbSQ5iH+ipyV6lfQUu1BZsTuYpwegJ44itXjOkEzWa7iNIncEbuxk5JaqZBIuMwBuPO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAXtdF1rbpyqRsCIlkm3A2eSMhGFSIqLIIi96xpxC2Y=;
 b=pZnLfMDoTSoVAFiLY/b55yZJAmYG1iPVZqhdea7I4k/Sb9lxNtnF2HM7EfKw91v+nBsu17Xx1Aq8yW5cEUNu0jr3NM9eGZQm4wJOOE4omOKPHflDhEBX9mLMueofJs8XRkoIRT3LamBi8ALd3CcuOQEOD1ZjJGeBr6NdcmEyR3V+2IJ4yAoGJVkPh54AjAxcTcdC58YJ/+GfvWKVJVL3VQkPZYVpv/9VwIqnHymc+QG3d8BQfsRjNwNDy4I6byjLJGVmNuGFQ7NmZocGchXy8ZIwN05IbdN2Co+KDuEgmUfCRHFiLX7o+w32HMakj4ui7jJYMWEow7egBogBM7dQgA==
Received: from AS8P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::14)
 by AS1PR10MB5628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Fri, 9 Sep
 2022 17:36:59 +0000
Received: from VE1EUR01FT080.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::92) by AS8P189CA0022.outlook.office365.com
 (2603:10a6:20b:31f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Fri, 9 Sep 2022 17:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT080.mail.protection.outlook.com (10.152.2.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 17:36:57 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 9 Sep 2022 19:36:57 +0200
Received: from [167.87.17.3] (167.87.17.3) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Fri, 9 Sep
 2022 19:36:56 +0200
Message-ID: <11b2e5e1-ac72-719d-4715-2d88c798de57@siemens.com>
Date: Fri, 9 Sep 2022 19:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core 1/2] README.control-system-backup.md: Add steps to
 explain control system backup
Content-Language: en-US
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220909080731.10848-1-Sai.Sathujoda@toshiba-tsip.com>
 <20220909080731.10848-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220909080731.10848-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.17.3]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--29.399000-8.000000
X-TMASE-MatchedRID: grK+ChACArwwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0b4FqzGb25nhyfD
	g9CC16hQe5Q84fGfhIauhMSEJPT6P+vzFc4lJMiq+rsq6C4LpseajZkb8TuLc0hwlOfYeSqxy73
	3NwuklsJYC5LPd7BvbUAc6DyoS2rIqQ4DH3i/D96V8OEK36USbyP4ZsyAE+lBzQWhka4AQNVMtA
	RS/dk7uCBQRBOQhaJiJzfpn/oR5121/NE2jc9NGAEYWRKQSgS1aFlk0tAiKs7FVAV8vDjN/1F5a
	dRR2Ej1r72Q0FogVWwW2uVp4ZO4NqnMkYbN78oQTdQXwxyJtjwPBdAcQklBEklABXpquwdljWP6
	asaL88UOzQEZTWW7CClgMlFy7N01DJGN6EeAAQrg9GpkpL2zRY1pcgBT/7NsJTy1bvT7q60iJN3
	aXuV/obwxqSK0GSPRpieYwslGH4k9vsGe1Y9+OWBk2JGEepwaQhiIAmWS9E2PR2u912hYRHe5jV
	G6a6tK1nkLa3J3C30J7wBcfi9JRDZhXG6YzizDwlMk1aZ495XeNzEkQjGrmP9N7e3lwkwbSeIje
	ghh/zO91tOpkTcVW5gULy4zAbFB7vdqwcnNq27hWj4HxSYpFTsr+6lvFGlynFVnNmvv47vCNGCM
	H2HgQMnJhTYnTng91AoUjyTnlokDPWKs2xM/Sx/AeVs+z6k97cCiNMOXTK2OjIrMSa2sR5Gi2Fv
	zLDzApKG9GN+fhxSpBBp93PYEuZCsMxjPvrHHfrupNiCzWk6GJQuxndzW1Adc+KHUCr/8B3pH4m
	l/Jke+eGAmqR+bQGUSrm6wRiNdp8lD1FcpzFpftuJwrFEhTbew1twePJJBrSFs54Y4wbX6C0ePs
	7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.399000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 8E800DA5AD810342061D35920F7F2897D18E7F888DF93FACCA950DDA23FADCF12000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT080:EE_|AS1PR10MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4438a9-93fb-4157-7f47-08da9289e52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kxS3tLN808Zpwo/Bez+rKeu2MR0bP2QNWs893UW5p5E5Ayaql6qQ+/TXW8Kncx49O0hiXJiHUMyJNb36Oqmxe3VWOaJL/7w17J7sDbfTOOhnCM/e2Fb2MFjmNTsJZAnDMT6zDeCCdoIB5MVX/LQLycIiVf+PDwnzrG9u0lXNaoJm2ucweBrTl0ESLMftL5jAAdwC4ewXMVoTHYGtwPQgF+vyveJA7wV+IKTamDCahrE+fNLmLnZAKyAJFQdvxyvzp9vNCRy1uLiSaXAkrwDKqn9XRNQH0IDxDZqLS2+gdOfu0obTtd2eUI09IOg99cqDZjqZ/gUDJa0zzzER2ZUNGKCw2qhXwHlMZQmGYvBpsxFUW5iIR12eJ1XQfvUMefP5BTBAtkSzMxpeCe76a/wrB1gAUvMeFG4Xrb9sYXk2qsyORrm6rn3oCrKYYDyXfJFeAxDBQRQKMrAYV1EFvGgZTg8ziCuNZ7zRQpM1cN4U4BHkuONXpQv2EXASkzzbqucmJDQSzU1mSa3lr6Ll695U8N6e6gXk3lxsc8ah1Hym//nG0B3YbwvFF/GFlQ64c62qQmlboacxBd+WpHw7qfWjf21dESH3EWtQxwTfKIWv3bsxm06Aw1207rB5MyWmU40Zn1GC8P+PTGlJiv7pNtPUIrqSOKmEE9h+y/gYUCVBCxOvATqQgCzaqbTh1LeQIAb2ORlq5SqLaRqJYVROgE2NEgLQ6z2+Plock7dX/gmEqZcqPwTYXoMBxMxNdgfpsWWjPlfn7GMCepl3e2HzQo6FQKHdgsFwaRjrRy2Jg9eno0UxiPGCN0pCHUBezKQ4AMPwTGOknEpa2iWeKIgNRB0P8w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(40470700004)(36840700001)(16526019)(47076005)(26005)(356005)(41300700001)(53546011)(2616005)(5660300002)(44832011)(30864003)(8936002)(83380400001)(186003)(40480700001)(36860700001)(8676002)(40460700003)(70586007)(82310400005)(4326008)(336012)(956004)(82960400001)(110136005)(6706004)(54906003)(2906002)(16576012)(478600001)(7636003)(86362001)(82740400003)(31696002)(70206006)(316002)(7596003)(31686004)(36756003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 17:36:57.7882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4b4438a9-93fb-4157-7f47-08da9289e52a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT080.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5628
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 17:37:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9483

On 09.09.22 10:07, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> Control system backup is an IEC security requirement to backup critical
> systems for disaster recovery and system migration program.
>=20
> This document demonstrates how control system backup can be taken using
> 'duplicity', and also provide steps to check the integrity and restore
> the backups.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README.control-system-backup.md | 194 ++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
>  create mode 100644 doc/README.control-system-backup.md
>=20
> diff --git a/doc/README.control-system-backup.md b/doc/README.control-sys=
tem-backup.md
> new file mode 100644
> index 0000000..4f4f9e1
> --- /dev/null
> +++ b/doc/README.control-system-backup.md
> @@ -0,0 +1,194 @@
> +# Overview
> +This document explains how to take system-level backup, verify integrity=
, and restore the backup file. It also mentions the demonstration which has=
 to be carried out using **duplicity** to perform both local and remote bac=
kups.
> +
> +# Description
> +There is always a chance for the data to get corrupted or lost due to so=
me unknown reasons. In those situations, system level backup is helpful so =
that if any data is lost then it can be restored back.=20
> +If there is a lot of space available in the system then **Local backup**=
 can be considered. But in some cases space will not be enough if we opt fo=
r daily backup. In that situation, it is better to choose remote backup whe=
re all the data in the system will be stored on a remote server.
> +
> +**Duplicity** provides facilities like system-level backup, encryption o=
f the data taken as a backup, verification of data integrity before restore=
 and finally the restoration of the data from the backup.=20
> +
> +# Pre-Requisites
> +1. CIP security image which includes **duplicity** package, to build the=
 image follow the steps described in the [README.security-testing.md](./REA=
DME.security-testing.md#build-cip-security-linux-image).
> +2. Additional storage in case of local backup, (Add the below lines in *=
*/kas/opt/security.yml** file to increase the rootfs size).
> +     ```
> +     local_conf_header:
> +          security_image_size: |
> +          ROOTFS_EXTRA =3D "8192"
> +     ```
> +3. Remote machine with Linux OS to store remote backups.

I think this should rather target our SWUpdate configuration variant
where the data is clearly separated from the read-only rootfs.

> +
> +# Local Backup & Restore
> +For the first backup taken it will be a **full backup** but after that i=
t will be incremental backups. If full backups are to be taken explicitly t=
hen add "full" in the command.
> +
> +The user can choose the data needed to be taken as backup. For example, =
in the below command /usr/bin directory is taken as backup in the /usr/loca=
l/backup location locally.

See above: bad example. It's /home and /var in a more realistic system.

> +Note: PASSPHRASE should be more than 8 characters.
> +```
> +root@demo:~# export PASSPHRASE=3D12345678
> +root@demo:~# duplicity /usr/bin file:///usr/local/backup
> +Local and Remote metadata are synchronized, no sync needed.
> +Last full backup date: none
> +No signatures found, switching to full backup.
> +--------------[ Backup Statistics ]--------------
> +StartTime 1661752359.77 (Mon Aug 29 05:52:39 2022)
> +EndTime 1661752362.69 (Mon Aug 29 05:52:42 2022)
> +ElapsedTime 2.92 (2.92 seconds)
> +SourceFiles 582
> +SourceFileSize 49793026 (47.5 MB)
> +NewFiles 582
> +NewFileSize 49793026 (47.5 MB)
> +DeletedFiles 0
> +ChangedFiles 0
> +ChangedFileSize 0 (0 bytes)
> +ChangedDeltaSize 0 (0 bytes)
> +DeltaEntries 582
> +RawDeltaSize 49779683 (47.5 MB)
> +TotalDestinationSizeChange 21135788 (20.2 MB)
> +Errors 0
> +```
> +Note: Two different data sets cannot be taken as backup into the same lo=
cation. So make sure when a data set different from the previous is taken a=
s backup, choose a different storage location.
> +
> +### Verification of data integrity before restore
> +We can verify whatever changes are made to our latest file system on com=
paring with a latest backup taken like below:=20
> +```
> +root@demo:/usr/bin# rm google-authenticator
> +root@demo:~# duplicity verify --compare-data -v4 file:///usr/local/backu=
p /usr/bin
> +Last full backup date: Mon Aug 29 05:52:31 2022
> +GnuPG passphrase for decryption:
> +Difference found: File . has mtime Mon Aug 29 05:56:13 2022, expected Mo=
n Aug 29 03:54:07 2022
> +Difference found: File google-authenticator is missing
> +Verify complete: 582 files compared, 2 differences found.
> +```
> +
> +#### Data Restore
> +The files can be restored only after integrity verification as shown abo=
ve so that the user will specifically know which files or directories have =
to be restored due to an unwanted change or deletion in the file system.
> +
> +```
> +root@demo:~# duplicity --file-to-restore google-authenticator file:///us=
r/local/backup /usr/bin/google-authenticator
> +```
> +Situation : If a directory containing 1000 files has around 250 files de=
leted and around 100 files modified. In that case it is not user friendly f=
or the user to individually restore such a huge list of modified files to r=
estore. Duplicity will not allow overwrite of remaining files in the direct=
ory so in that case the only possible solution is to delete the entire dire=
ctory and restore it from the backup.
> +
> +The --file-to-restore switch should be removed if the user wants to rest=
ore a complete directory like shown below.=20
> +```
> +root@demo:~# duplicity file:///usr/local/backup /usr/bin/
> +```
> +
> +### Listing all the files in the backup
> +To check all the contents of a backup do as shown below:
> +```
> +root@demo:~# duplicity list-current-files file:///usr/local/backup
> +Local and Remote metadata are synchronized, no sync needed.
> +Last full backup date: Mon Aug 29 05:52:31 2022
> +Mon Aug 29 03:54:07 2022 .
> +Mon Aug 29 03:52:37 2022 Mail
> +Thu Sep 24 08:36:09 2020 [
> +Thu Jan 20 20:10:35 2022 addpart
> +Sun Jan 16 12:36:56 2022 aide
> +Thu Jun 10 08:53:34 2021 apt
> +Thu Jun 10 08:53:34 2021 apt-cache
> +Thu Jun 10 08:53:34 2021 apt-cdrom
> +Thu Jun 10 08:53:34 2021 apt-config
> +...
> +```
> +
> +# Remote Backup & Restore
> +### Setting up the environment on remote server
> +In the Local server, generate a pair of RSA keys that will be used for a=
uthentication during remote backup.
> +```
> +root@demo:~# ssh-keygen -t rsa -b 2048 -N "" -f /root/.ssh/id_rsa
> +root@demo:~# ssh-copy-id -i ~/.ssh/id_rsa remoteuser@remoteserver-ip
> +```
> +
> +Create a directory in remote server for keeping the backup files
> +```
> +root@demo:~# ssh remoteuser@remoteserver mkdir -p sftp_remote_bk_testing=
/first_backup
> +```
> +
> +### Generation of GPG keys for encryption of data
> +Create a file name gen-key-script and add the parameters like below:
> +```
> +root@demo:~# cat >foo <<EOF
> +     Key-Type: DSA
> +     Key-Length: 1024
> +     Subkey-Type: ELG-E
> +     Subkey-Length: 1024
> +     Name-Real: username
> +     Name-Email: usermailID
> +     Expire-Date: 0
> +     # passphrase should be more than 8 characters
> +     Passphrase: 123456789
> +EOF
> +root@demo:~# gpg --batch --gen-key foo
> +gpg: Generating a basic OpenPGP key
> +gpg: key AE57464HFG4 marked as ultimately trusted
> +gpg: revocation certificate stored as '/root/.gnupg/openpgp-revocs.d/E4C=
84C97B37BB24947E4522DA4B60C25738850E9.rev'
> +```
> +Use the encrypted key generated as above command and the encrypt key is =
AE57464HFG4 in the remote backup.
> +

Manual setup on the target is also a suboptimal example as no real
system will likely ever be operated like that. Better define a workflow
and the required recipes to manage and inject the keys during image build.

> +### Remote Backup
> +```
> +root@demo:~# duplicity --encrypt-key "AE57464HFG4" /usr/bin sftp://remot=
euser@remoteserver:/sftp_remote_bk_testing/first_backup
> +```
> +Find the backed up files in the remote location using the below command
> +```
> +root@demo:~# ssh remoteuser@remoteserver ls /home/remoteuser/sftp_remote=
_bk_testing/first_backup
> +- duplicity-full.20220829T070950Z.manifest.gpg=20
> +- duplicity-full.20220829T070950Z.vol1.difftar.gpg =20
> +- duplicity-full-signatures.20220829T070950Z.sigtar.gpg
> +```
> +
> +### Verification of integrity after recent backup in remote server
> +```
> +root@demo:~# duplicity verify --encrypt-key "AE57464HFG4" --compare-data=
  sftp://remoteuser@remoteserver:/sftp_remote_bk_testing/first_backup /usr/=
bin
> +Local and Remote metadata are synchronized, no sync needed.5CAE2A504" --=
compare-data  sftp://remoteuser@remoteserver:/sftp_remote_bk_testing/first_=
backup /usr/bin
> +Last full backup date: Mon Aug 29 07:09:50 2022
> +GnuPG passphrase for decryption:=20
> +Difference found: File . has mtime Mon Aug 29 07:14:15 2022, expected Mo=
n Aug 29 06:00:22 2022
> +Difference found: File google-authenticator is missing
> +Verify complete: 582 files compared, 2 differences found.
> +```
> +
> +#### Restoration of data from remote server
> +```
> +root@demo:~# duplicity --file-to-restore google-authenticator sftp://rem=
oteuser@remoteserver:/sftp_remote_bk_testing/first_backup /usr/bin/google-a=
uthenticator
> +```
> +
> +# Automatic Backup scheduling using cron service
> +To avoid operator overhead to regularly take system backup, it is necess=
ary to automate the backup so that the data backup will be **up-to-date**.
> +
> +While automating this backup process, it is suggestible to use remote ba=
ckup based on space issue.=20
> +
> +Below a simple script which shall be added in the crontab to run on a da=
ily basis.
> +
> +```
> +#!/bin/bash
> +echo "This will execute the backup on the first minute, first hour , eve=
ry day"
> +export PASSPHRASE=3D12345678
> +duplicity --encrypt-key "AE57464HFG4" /usr/bin sftp://remoteuser@remotes=
erver:/sftp_remote_bk_testing/first_backup
> +unset PASSPHRASE
> +```
> +
> +In this demo script, the /usr/bin is being taken as a backup. The user c=
an replace based on the requirement.
> +The passphrase should also match the one assigned by the user during GPG=
 keys creation.
> +
> +Save the file (daily_backup.sh) in a known path and start the cron servi=
ce.
> +```
> +root@demo:~# systemctl start cron
> +```
> +Check the status of the service (expected to be in running state)
> +```
> +root@demo:~# systemctl status cron
> +=E2=97=8F cron.service - Regular background program processing daemon
> +     Loaded: loaded (/lib/systemd/system/cron.service; enabled; vendor p=
reset: enabled)
> +     Active: active (running) since Mon 2022-08-29 12:11:25 UTC; 12min a=
go
> +```
> +Open the crontab=20
> +```
> +root@demo:~# crontab -e
> +```
> +Add the below line at the end of the crontab file if the user needs a ba=
ckup on daily basis onto the remote server.
> +```
> +0 0 * * * /root/daily_backup.sh
> +```
> +After saving the crontab, the below message should be displayed.
> +**crontab: installing new crontab**
> +The user can verify this automation by checking the contents of the remo=
te backup folder regularly.

The crontab setup comes closes to what I would have expected from this
readme. What we are still missing are recipes to set that up during
build and do configure the backup sources there as well. Then AT MOST
the restore should remain as manual step.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


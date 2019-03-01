package com.platform.generator.util;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.log4j.Logger;



/**
 * Twitter_Snowflake<br>
 * SnowFlake的结构如下(每部分用-分开):<br>
 * 0 - 0000000000 0000000000 0000000000 0000000000 0 - 00000 - 00000 - 000000000000 <br>
 * 1位标识，由于long基本类型在Java中是带符号的，最高位是符号位，正数是0，负数是1，所以id一般是正数，最高位是0<br>
 * 41位时间截(毫秒级)，注意，41位时间截不是存储当前时间的时间截，而是存储时间截的差值（当前时间截 - 开始时间截)
 * 得到的值），这里的的开始时间截，一般是我们的id生成器开始使用的时间，由我们程序来指定的（如下下面程序IdWorker类的startTime属性）。41位的时间截，可以使用69年，年T = (1L << 41) / (1000L * 60 * 60 * 24 * 365) = 69<br>
 * 10位的数据机器位，可以部署在1024个节点，包括5位datacenterId和5位workerId<br>
 * 12位序列，毫秒内的计数，12位的计数顺序号支持每个节点每毫秒(同一机器，同一时间截)产生4096个ID序号<br>
 * 加起来刚好64位，为一个Long型。<br>
 * SnowFlake的优点是，整体上按照时间自增排序，并且整个分布式系统内不会产生ID碰撞(由数据中心ID和机器ID作区分)，并且效率较高，经测试，SnowFlake每秒能够产生26万ID左右。
 */
public class PrimaryKeyIdWorker {
	
	private static final Logger logger = Logger.getLogger(PrimaryKeyIdWorker.class);

	private final long workerId;
	// 1376 1103 3134 6 13*4
	private final static long twepoch = 1303895660503L;
	private long sequence = 0L;
	private final static long workerIdBits = 10L;
	protected final long maxWorkerId = -1L ^ -1L << PrimaryKeyIdWorker.workerIdBits;
	private final static long sequenceBits = 12L;

	private final long workerIdShift = PrimaryKeyIdWorker.sequenceBits;
	private final long timestampLeftShift = PrimaryKeyIdWorker.sequenceBits + PrimaryKeyIdWorker.workerIdBits;
	private final static long sequenceMask = -1L ^ -1L << PrimaryKeyIdWorker.sequenceBits;

	private final static String RANDOM_CHAR = "ABCDEFGHIJKLMNPQRSTUVWXYZ";

	private long lastTimestamp = -1L;

	// public PrimaryKeyIdWorker(long workerId) {
	// super();
	// if (workerId > this.maxWorkerId || workerId < 0) {
	// throw new IllegalArgumentException(String.format("worker Id can't be
	// greater than %d or less than 0",
	// this.maxWorkerId));
	// }
	// this.workerId = workerId;
	// }

	public PrimaryKeyIdWorker() {
		super();
		this.workerId = 1L;
	}

	public synchronized long nextId() {
		long timestamp = this.timeGen();
		if (this.lastTimestamp == timestamp) {
			this.sequence = this.sequence + 1 & PrimaryKeyIdWorker.sequenceMask;
			if (this.sequence == 0) {
				timestamp = this.tilNextMillis(this.lastTimestamp);
			}
		} else {
			this.sequence = 0;
		}
		if (timestamp < this.lastTimestamp) {
			try {
				throw new RuntimeException(String.format("Clock moved backwards.  Refusing to generate id for %d milliseconds", (this.lastTimestamp - timestamp)));
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}
		}
		this.lastTimestamp = timestamp;
		return (timestamp - PrimaryKeyIdWorker.twepoch << this.timestampLeftShift | this.workerId << this.workerIdShift | this.sequence);

	}

	private long tilNextMillis(long lastTimestamp) {
		long timestamp = this.timeGen();
		while (timestamp <= lastTimestamp) {
			timestamp = this.timeGen();
		}
		return timestamp;
	}

	private long timeGen() {
		return System.currentTimeMillis();
	}

	/**
	 * 生成20位主键
	 * 
	 * @return
	 */
	public String getPrimaryKey() {
		String nextId = nextId() + "";
		int len = nextId.length();
		int diff = 20 - len;
		if (diff > 0) {
			nextId = RandomStringUtils.random(diff, RANDOM_CHAR) + nextId;
		} else if (diff < 0) {
			nextId = nextId.substring(0, 20);
		}
		return nextId;
	}
	
	 /** 测试 */
    public static void main(String[] args) {
    	PrimaryKeyIdWorker idWorker = new PrimaryKeyIdWorker();
        for (int i = 0; i < 10; i++) {
            String id = idWorker.getPrimaryKey();
            System.out.println(id);
        }
    }

}

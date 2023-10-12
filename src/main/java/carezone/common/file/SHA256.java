package carezone.common.file;

import java.security.MessageDigest;

public class SHA256 {
	public static String getSHA256(String useremail) 
	{
		StringBuffer result = new StringBuffer();
		try
		{
			/*MessageDiget객체 확보 해쉬방식은 SHA-256방식
			 *  MD2, DM4, MD5, SHA-1, SHA-256, SHA-512 방식이 있음
			 */
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			//보안을 위해서 diget생성
			byte[] salt = "Encrytion Salt.".getBytes();
			
			digest.reset();
			// update를 통하여 다이제스트를 갱신
			digest.update(salt);
			
			byte[] chars = digest.digest(useremail.getBytes("UTF-8"));
			//System.out.println(chars);
			for(int i =0; i< chars.length; i++)
			{
				System.out.println("이전헥스값:"+chars[i]);
				String hex = Integer.toHexString(0xFF & chars[i]);
				//System.out.println("헥스값:"+hex);
				if(hex.length() == 1) {
					//System.out.println("한글자인 헥스:"+hex);
					//System.out.println("0을 더하기전:"+result);
					result.append("0");
					//System.out.println("0을 더한후:"+result);
					
				}
				result.append(hex);
				//System.out.println("헥스값 결과"+result);
				
			}
		}
		catch(Exception e) {e.printStackTrace();}
		System.out.println("해쉬끝");
		return result.toString();

	}
}
package cqube.SpecAPI;

import com.intuit.karate.junit5.Karate;
class UsersRunner {
    
    @Karate.Test
    Karate testAll() {

        return Karate.run().relativeTo(getClass()) ;
    }
    @Karate.Test
    Karate testTags() {
         return Karate.run().tags("@t1").relativeTo(getClass());
    }
}
